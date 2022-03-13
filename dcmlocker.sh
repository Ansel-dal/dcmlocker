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


#install .Net v5.0
wget -O - https://raw.githubusercontent.com/pjgpetecodes/dotnet5pi/master/install.sh | sudo bash

#create dcmlocker.service
echo -e "[Unit]
Description=dcmlocker 
[Service]
 WorkingDirectory=/var/www/DCMLocker
 ExecStart=/opt/dotnet/dotnet /var/www/DCMLocker/DCMLocker.Server.dll
 Restart=always   
 SyslogIdentifier=dotnet-dcmlocker    
 User=root
 Environment=ASPNETCORE_ENVIRONMENT=Production 
[Install]
 WantedBy=multi-user.target

" >> /etc/systemd/system/dcmlocker.service

#create service
sudo systemctl enable dcmlocker.service
