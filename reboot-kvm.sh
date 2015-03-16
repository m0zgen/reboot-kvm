#!/bin/bash
 
# Shutdown or destroy all KVM quests and reboot or shutdown KVM node
# Author Yevgeniy Goncharov aka xck, http://sys-admin.kz

shutdown_quests(){
LIST_VM=`virsh list | grep running | awk '{print $2}'`
TIMEOUT=90
DATE=`date -R`
LOGFILE="/var/log/kvm-quest-shutdown.log"

#if [ "x$activevm" =  "x" ]
#then
# exit 0
#fi

# check log file
if [[ ! -e $LOGFILE ]]; then
	touch $LOGFILE
	#echo "$LOGFILE created" 1>&2
elif [[ ! -d $LOGFILE ]]; then
	echo "$DATE : Start script" >> $LOGFILE
fi


for activevm in $LIST_VM
do
	PIDNO=`ps ax | grep $activevm | grep kvm | cut -c 1-6 | head -n1`
	echo "$DATE : Shutdown : $activevm : $PIDNO" >> $LOGFILE
	virsh shutdown $activevm > /dev/null
	COUNT=0
	while [ "$COUNT" -lt "$TIMEOUT" ]
	do
		ps --pid $PIDNO > /dev/null
		if [ "$?" -eq "1" ]
			then
			COUNT=110
		else
			sleep 5
			COUNT=$(($COUNT+5))
		fi
	done
	if [ $COUNT -lt 110 ]
		then
		echo "$DATE : $activevm not successful force shutdown" >> $LOGFILE
		virsh destroy $activevm > /dev/null
	fi
done
}

#notify
note(){
	echo -e "--------------------------------------------------------\n"
	echo -e "\nYou need usage script with arguments: --reboot ot --shutdown:\n\n $0 --shutdown\n"
	#printf "1111\n22222\n\nYou can use arguments: $0 --help"
	exit 1
}

# shutdown or reboot
reboot_node(){
	reboot
}

shutdown_node(){
	shutdown -h now
}


if [ $# -ne 1 ]; then
    note
fi

for i in "$@" ; do

    if [[ $i == "--reboot" ]] ; then
    	shutdown_quests
        reboot_node
        break
    fi

    if [[ $i == "--shutdown" ]] ; then
    	shutdown_quests
        shutdown_node
        break
    fi

done
