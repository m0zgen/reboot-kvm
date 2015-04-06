#!/bin/bash
 
# Install script reboot-kvm.sh
# Author Yevgeniy Goncharov aka xck, http://sys-admin.kz
# Usage from HTTP - curl http://Server/install.sh | sh

VAR=/usr/local/sbin
RUN=/usr/bin/reboot-kvm
SCR=/usr/local/sbin/reboot-kvm.sh

curl http://xxx.xxx.xxx.x/scripts/reboot-kvm/reboot-kvm.sh > $SCR
chmod +x $SCR


echo -e "export S_PATH=$VAR\n\$S_PATH/reboot-kvm.sh $*" > $RUN
chmod +x $RUN

echo -e "Install done!"

