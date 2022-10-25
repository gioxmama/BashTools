#!/bin/bash
#Datum:		19.10.2022
#Autor:		AFIMG - Giosue Masiello
#Aufgabe:	Updates erledigen mit Konsole-output & mit Logs im /tmp
#Version:	2.0
#Grund:		Updates vereinfachen

antwort=0
sicherheit=5
while [ $antwort != 4 ]
do
	echo "!!Run this script as superuser!!"
	echo "SUDO  Update menu  SUDO"
	echo "+----------------------------+"
	echo "|1.Updates mit Output        |"
	echo "|2.1ste Option mit Datumlog  |"
	echo "|3.Letzte Update             |"
	echo "|4.Programm schliessen       |"
	echo "+----------------------------+"
	read -p "Was moechten Sie wählen (1,2,3,4): " antwort

	case $antwort in

		1)echo "Updates mit Output"
	  	  echo "Moechten Sie fortfahren?"
	  	  read -p "1=Ja 0=Nein: " sicherheit
				if [ $sicherheit = 1 ]
				then
					echo "Los geht's"
					sleep 2
					cmd= apt update && apt upgrade -y && apt autoremove -y
					break
				else
					echo "!Falsche Imput!"
				fi
		;;

		2)echo "Updates mit Output und Datum log"
	  	  echo "Moechten Sie fortfahren?"
	  	  read -p "1=Ja 0=Nein: " sicherheit
				if [ $sicherheit = 1 ]
				then
					echo "Los geht's"
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
					echo "!Falsche Imput!"
				fi
		;;

		3) cat /tmp/update-grade-remove/lastupdate.log
		   break
		;;

		4) echo "Programm wird beendet"
		;;

		*) echo "!Falsche Imput!"
		;;

		esac
done
