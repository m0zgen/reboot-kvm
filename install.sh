#!/bin/bash
 
# Shutdown or destroy all KVM quests and reboot or shutdown KVM node
# Author Yevgeniy Goncharov aka xck, http://sys-admin.kz

VAR=/usr/local/sbin
RUN=/usr/bin/reboot-kvm
SCR=/usr/local/sbin/reboot-kvm.sh

curl http://172.20.0.111/scripts/reboot-kvm/reboot-kvm.sh > $SCR
chmod +x $SCR


echo -e "export S_PATH=$VAR\n\$S_PATH/reboot-kvm.sh $*" > $RUN
chmod +x $RUN

echo -e "Install done!"

