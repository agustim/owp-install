#!/bin/bash

# 0. Define variables
HW=$(arch)
[ "$HW" == "i686" ] && HW="i386"
[ "$HW" == "i486" ] && HW="i386"

[ $(id -u) == 0 ] && {
	echo "Please, run as root.";
	exit;
} 

[ "$HW" == "amd64" -o "$HW" == "i386" ] && {
	echo "Only install in intel platform.";
	exit;
}

# 0bis. remove deb cdrom
sed -i -e 's/deb cdrom/#deb cdrom/g' /etc/apt/sources.list

# 1. Arreglar /etc/sysctl.conf
sysctl net.ipv4.ip_forward=1 net.ipv4.neigh.default.gc_thresh2=2048 net.ipv4.neigh.default.gc_thresh3=4096 net.ipv4.conf.default.rp_filter=1 net.ipv4.conf.default.accept_source_route=0 net.ipv4.conf.default.send_redirects=1 net.ipv4.conf.default.forwarding=1 net.ipv4.conf.default.proxy_arp=0 net.ipv4.conf.all.send_redirects=0 net.ipv4.conf.all.rp_filter=1 net.ipv4.icmp_echo_ignore_broadcasts=1 net.ipv4.tcp_syncookies=1 net.ipv6.conf.all.forwarding=1 kernel.sysrq=1 kernel.core_uses_pid=1 kernel.msgmnb=65536 kernel.msgmax=65536 kernel.shmmax=68719476736 kernel.shmall=4294967296 fs.file-max=262144

# 2. Ruby
apt-get -y install ruby1.8 rubygems1.8 libsqlite3-ruby1.8 ruby-switch
ruby-switch --set ruby1.8

# 3. Add openvz
#echo "deb http://download.openvz.org/debian wheezy main" > /etc/apt/sources.list.d/openvz.list
# 3.1 Add key
#wget -qO - "http://ftp.openvz.org/debian/archive.key" | apt-key add -


# 3. Packages 
cd packages

# 3.1 install .deb
dpkg --install linux-image-openvz-686_042+1_i386.deb ploop_1.12.1-1_i386.deb vzctl_4.7.2-1_i386.deb vzquota_3.1-1_i386.deb vzstats_0.5.3-1_all.deb libploop1_1.12.1-1_i386.deb linux-image-2.6.32-openvz-686_042stab085.17_i386.deb libcgroup1_0.38-1_i386.deb parted_2.3-12_i386.deb libparted0debia
n1_2.3-12_i386.deb

# 4. Update
apt-get update && apt-get upgrade



# 5. Install packages
apt-get -y install linux-image-openvz-${HW} vzctl vzquota ploop vzstats

# 6. Install packages to build images
apt-get -y install fakeroot alien




# 7. Install script
wget -O - http://ovz-web-panel.googlecode.com/svn/installer/ai.sh | sh -


