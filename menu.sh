#!/bin/bash
# Bhavya Shah A01023981
while true
do
	clear
  	echo "
			Assingment 1 comp 7006
		"
	 cat << 'MENU'
	1................................... Install httpd
 	2................................... Install nfs-utils
 	3................................... Install samba
 	4................................... Configure package
 	5................................... Install DNF package
 	6................................... Reboot the system
 	7................................... DNF upgrade
 	8................................... Quit


MENU
	echo '           Select option, then Return >'
	read ltr rest
	case ${ltr} in
		#Install httpd
		[1])	dnf install httpd
			;;

		#Install nfs-utils
		[2])	dnf install nfs-utils
			;;

		#Install samba
		[3])	dnf install samba
			;;

		#Configure package
		[4])	read -p "Enter DNF package name to configure: " package
					if [[ "$package" = "httpd" ]]; then
						sh httpd.sh
					elif [[ "$package" = "samba" || "$package" = "nfs" ]]; then
						sh samba.sh
					else
					     echo "Not a valid package!"
					fi
			;;

		#Install DNF package
		[5])	read -p "Enter DNF package name : " package
				echo "Installing $package"
				dnf install $package


				# read -p "Do you want to configure $package [y/N] : " confirm
				# 	if test "$confirm" = "y"
				# 	then
				# 	     #Run option 3
				# 	else
				# 	     echo "$package installed!"
				# 	fi
			;;


		#Reboot the system
		[6])	reboot
			;;

		#Quit
		[7])	dnf upgrade
			;;

		[8])	exit
			;;

		[Ee])	echo
			echo -n '	Enter file to edit >'
			read fn rest
			vi ${fn}	;;
		*)	echo; echo Did not recognize choice: ${ltr} ;;
	esac
	echo; echo ' Press Enter to continue!'
	read rest
done
