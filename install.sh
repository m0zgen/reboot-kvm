#!/bin/bash
 
# Install script reboot-kvm.sh
# Author Yevgeniy Goncharov aka xck, http://sys-admin.kz
# Usage from HTTP - curl http://Server/install.sh | sh

VAR=/usr/local/sbin
RUN=/usr/bin/reboot-kvm
SCR=/usr/local/sbin/reboot-kvm.sh

install(){
	curl http://Server/scripts/reboot-kvm/reboot-kvm.sh > $SCR
	chmod +x $SCR


	echo -e "export S_PATH=$VAR\n\$S_PATH/reboot-kvm.sh \$*" > $RUN
	chmod +x $RUN

	echo -e "\nInstall done!"
}

uninstall(){
	/usr/bin/rm $RUN
	/usr/bin/rm $SCR

	echo -e "\nUninstall done!"
}

if [ $# -eq 0 ]; then
    install
    exit 1
fi

for i in "$@" ; do

    if [[ $i == "--uninstall" ]] ; then
    	uninstall
        break
    fi

done

