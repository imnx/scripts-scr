#!/usr/bin/sudo /bin/bash

curDIR="$(pwd)"

echo "deb http://mirror.internode.on.net/pub/debian/ stretch main contrib non-free
deb-src http://mirror.internode.on.net/pub/debian/ stretch main contrib non-free

deb http://mirror.internode.on.net/pub/debian-security/ stretch/updates main contrib non-free
deb-src http://mirror.internode.on.net/pub/debian-security/ stretch/updates main contrib non-free

# stretch-updates, previously known as 'volatile'
deb http://mirror.internode.on.net/pub/debian/ stretch-updates main contrib non-free
deb-src http://mirror.internode.on.net/pub/debian/ stretch-updates main contrib non-free" > /etc/samba/smb.conf

apt-get update

# Upgrade distro and install required packages.
apt-get -y dist-upgrade
apt-get -y install curl sudo perl-base gpm gfxboot gxfboot-themes plymouth plymouth-themes plymouth-theme-hamara open-vm-tools-dev python python-pip wget net-tools apt-utils psmisc dnsutils dialog pv build-essential cmake bison flex nasm yasm automake autoconf autogen autopoint autoproject autotools-dev libtool intltool doxygen texinfo texi2html byacc git cvs subversion mercurial openssh-server cifs-utils samba

# Install GitLab-CE.
apt-get install curl openssh-server ca-certificates postfix
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash

git clone -b master --depth=1 https://github.com/maximilienGilet/Elegant-GRUB2 /usr/src/elegant-grub2
cd "/usr/src/elegant-grub2"
./install.sh

cd "${curDIR}"

echo "GRUB_DEFAULT='0'
GRUB_TIMEOUT='5'
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT='net.ifnames=0 splash quiet'
GRUB_CMDLINE_LINUX='net.ifnames=0 splash'

GRUB_GFXMODE='1366x768x32'
GRUB_GFXPAYLOAD='1366x768x32'
GRUB_THEME=''

GRUB_DISABLE_LINUX_UUID='false'
GRUB_DISABLE_RECOVERY='false'

GRUB_INIT_TUNE='1750 523 1 392 1 523 1 659 1 784 1 1047 1 784 1 415 1 523 1 622 1 831 1 622 1 831 1 1046 1 1244 1 1661 1 1244 1 466 1 587 1 698 1 932 1 1195 1 1397 1 1865 1 1397 1'" > /etc/default/grub

update-grub && update-grub2
