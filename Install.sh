#!/bin/sh
#
#  SIAT Monitoring-Bot Acehprov
#  Script monitoring server ini dibuat untuk mempermudah kerja Sys-Admin Acehprov 
#  
#  Cara penginstallan : 
#						Berikan akses eksekusi ke File Install.sh	(chmod 754 Install.sh)
#						Jalankan Install.sh (./install.sh)
#
#  Author : Zaki Akhyar (zaki.akhyar@hotmail.com)
# 			TIM-SIAT @ 2019 | Dinas Komunikasi Informasi dan Sandi Pemerintah Aceh
#  License : MIT (https://opensource.org/licenses/MIT)
#

if [[ $EUID -ne 0 ]]; then
   echo "Jalankan dengan hak akses ROOT" 1>&2
   exit 1
fi

chmod 754 -R main
mkdir /opt/SIAT-MonitoringClient
cd main; cp send getinfo /opt/SIAT-MonitoringClient/; cp siatlog.service /etc/systemd/system/
systemctl daemon-reload; systemctl enable siatlog.service; systemctl start siatlog.service

printf "Selamat instalasi selesai !\n Jalankan siatlog dengan : \n\t systemctl (start|status|stop|restart) siatlog \n"