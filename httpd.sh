#!/bin/bash
#Bhavya Shah A01023981
read -p "Create a username: " username
read -s -p "Create a password: " pwd
echo "Making useraccount."
useradd $username
echo "$pwd" | passwd "$username" --stdin
echo "Creating user directory"
cd /home/$username
mkdir public_html
cd public_html
echo "Creating an index file."
echo "Welcome to Index.html page" > index.html
echo "Now we Changing the required permissions."
chmod -R 755 /home/$username

echo "Backing up the userdir.conf file"

rm -rf /etc/httpd/conf.d/userdir.conf
cp /home/scripts/userdir.conf /etc/httpd/conf.d/userdir.conf
cd /etc/httpd/conf.d/

echo $username | sed -i 's/foo/'${username}'/' userdir.conf

mkdir -p /var/www/html/passwords
chmod -R 755 /var/www/html/passwords

echo "Changing password file."

cd /var/www/html/passwords
echo "Create a new password for website login"
htpasswd -c pwdfile $username

cd /var/www/html/passwords
chmod 755 pwdfile
systemctl restart httpd

echo -e "\x1B[32mApache server created \x1B[0m"

read -p "Would you like to edit the index page? [y/N] " check
					if [[ "$check" = "y" || "$check" = "yes" ]]; then
						cd /home/$username
						cd public_html
						nano index.html
					elif [[ "$check" = "n" || "$check" = "no" ]]; then
						read -p "add more items to the folder? [y/N] " anothercheck
							if [[ "$anothercheck" = "y" || "$anothercheck" = "yes" ]]; then
								cd /home/$username
								cd public_html
							else
							     echo "Thank you"
							fi
					else
					     echo "Not valid "
					fi

#This line below will open up index page
xdg-open http://localhost/~$username
