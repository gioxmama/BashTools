#!/bin/bash
#Date:		19.10.2022
#Author:	gioxmama#5021
#Purpose:	CLI interface for APT package manager with datelog possibility in /tmp
#Version:	2.0
#Why:		To make a ground for automatic updates

answer=0
usure=5
while [ $answer != 4 ]
do
	echo "!!Run this script as superuser!!"
	echo "SUDO  Update menu  SUDO"
	echo "+----------------------------+"
	echo "|1.Updates with output       |"
	echo "|2.1st option with datelog   |"
	echo "|3.Last update               |"
	echo "|4.Close the interface       |"
	echo "+----------------------------+"
	read -p "Make your choice (1,2,3,4): " answer

	case $answer in

		1)echo "Updates with output"
	  	  echo "Do you want to start?"
	  	  read -p "1=Yes 0=No: " usure
				if [ $usure = 1 ]
				then
					echo "Let's go"
					sleep 2
					cmd= apt update && apt upgrade -y && apt autoremove -y
					break
				else
					echo "!Wrong Imput!"
				fi
		;;

		2)echo "Updates with Output and datelog"
	  	  echo "Do you want to start?"
	  	  read -p "1=Yes 0=No: " usure
				if [ $usure = 1 ]
				then
					echo "Let's go"
					sleep 2
					
					if [[ -f "/tmp/update-grade-remove" ]]
					then
    					cmd= touch /tmp/update-grade-remove/lastupdate.log
					else
						cmd= mkdir /tmp/update-grade-remove
						cmd= touch /tmp/update-grade-remove/lastupdate.log
					fi

					cmd= apt-get update && apt-get upgrade -y && apt-get autoremove -y
					echo "$(date +"%d-%m-%Y")" > /tmp/update-grade-remove/lastupdate.log
					break
				else
					echo "!Wrong Imput!"
				fi
		;;

		3) cat /tmp/update-grade-remove/lastupdate.log
		   break
		;;

		4) echo "Closing the CLI-Interface"
		;;

		*) echo "!Wrong Imput!"
		;;

		esac
done
