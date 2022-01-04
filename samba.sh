#!/bin/bash
# Bhavya Shah A01023981
read -p "Create a username: " username
read -s -p "Create a password: " pwd

echo "Creating useraccount!"

useradd $username
echo "$pwd" | passwd "$username" --stdin
echo "User account created!"

echo "Changing the required permissions."

chmod -R 777 /home/$username
cd /home/$username
echo "Creating some dummy files."

echo "Text file 1" > file1.txt
echo "Text file 2" > file2.txt
echo "Enabling nfs-service.service."

systemctl enable nfs-server.service
read -p "Enter the client IP address: " clientip
echo "/home/$username $clientip(rw,no_root_squash)" > /etc/exports

systemctl restart nfs-server
#/usr/sbin/exportfs -v
exportfs
echo "Restarting nfs-server."

systemctl restart nfs-server
echo "Configuring Samba"

echo "[$username]
comment = Windows Share to the NFS challenged
path = /home/$username
public = yes
writable = yes
guest ok = yes
printable = no" >> /etc/samba/smb.conf

echo "Making password Samba password for Windows user."

echo -ne "$pwd\n$pwd\n" | smbpasswd -a -s $username
echo "Samba password for Windows user created!"
echo "Enabling smb.service"
systemctl enable smb.service
echo "Restarting smb.service"

systemctl restart smb #restart samba
echo -e "\x1B[32mNFS and Samba succssfully configured! \x1B[0m"
