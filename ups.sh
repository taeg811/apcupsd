#!/bin/bash

bcharge=$(/usr/sbin/apcaccess | grep BCHARGE |awk '{print $3}')
stat=$(/usr/sbin/apcaccess | grep STATUS |awk '{print $3}')
#echo $bcharge
#echo $stat

# round bcharge  - drop all after point
bcharge_r=${bcharge%.*}


if [ "$stat" == "ONBATT" ] || [ $bcharge_r -lt 50 ]
 then
# echo "ALARM ONBATT"

echo "ALARM Ups status $stat and battery $bcharge" | gnokii --config /home/sms.conf --sendsms +79999999996
echo "ALARM Ups status $stat and battery $bcharge" | gnokii --config /home/sms.conf --sendsms +79278888888

/usr/bin/curl -s -X POST https://api.telegram.org/bot1175435128:AXMdFMly4URCaLhn9VyY/sendMessage -d chat_id=509108 -d text="ALARM Ups status $stat and battery $bcharge"		
# else
# echo "ALL GOOD"
 fi