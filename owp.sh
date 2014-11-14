#!/bin/bash

# 0. Define variables
HW=$(arch)

[ $(id -u) == 0 ] && {
	echo "Please, run as root.";
	exit;
} 

[ "$HW" == "amd64" -o "$HW" == "i646" ] && {
	echo "Only install in intel platform.";
	exit;
}


# 1. Add openvz
echo "deb http://download.openvz.org/debian wheezy main" > /etc/apt/sources.list.d/openvz.list

# 1.1 Add key
wget -qO - "http://ftp.openvz.org/debian/archive.key" | apt-key add -

# 2. Update
apt-get update && apt-get upgrade

# 3. Install packages
apt-get install linux-image-openvz-${HW} libsqlite3-dev vzctl vzquota apache2-prefork-dev libapr1-dev libaprutil1-dev

# 4. Install script
wget -O - http://ovz-web-panel.googlecode.com/svn/installer/ai.sh | sh -


