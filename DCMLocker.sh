#!/bin/bash

#update
sudo apt update

#install nginx
sudo apt install nginx -y
sudo service nginx start

#install samba
mkdir /home/bananapi/share
sudo apt-get install samba samba-common-bin samba-client -y
sudo mkdir /home/pi/share/
echo -e "[share]
   comment = Share Directory
   path = /var/www
   browseable = Yes
   writeable = Yes
   only guest = no
   public = yes
   force user = pi

" >> /etc/samba/smb.conf
sudo service smbd restart

chmod ugo+rwx /var/www/

