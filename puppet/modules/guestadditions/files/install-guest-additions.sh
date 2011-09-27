#!/bin/bash

GUEST_ADDITIONS_VERSION=4.1.2
URL="http://download.virtualbox.org/virtualbox/${GUEST_ADDITIONS_VERSION}/VBoxGuestAdditions_${GUEST_ADDITIONS_VERSION}.iso"

apt-get -y install linux-headers-$(uname -r) dkms wget
cd /opt
wget $URL
mount "VBoxGuestAdditions_${GUEST_ADDITIONS_VERSION}.iso" -o loop /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
rm *.iso
