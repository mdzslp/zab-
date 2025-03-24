#!/bin/bash

cat << EOF
{ "data": [
  { "{#ITEMNAME}":"important_metrics1" },
  { "{#ITEMNAME}":"important_metrics2" },
  { "{#ITEMNAME}":"important_metrics3" }
]}
EOF

# build up list of values in /tmp/zdata.txt
agenthost="top24"
zserver="127.0.0.1"
zport="10051"

cat /dev/null > /tmp/zdata.txt
for item in "important_metrics1" "important_metrics2" "important_metrics3"; do
  randNum="$(( (RANDOM % 100)+1 ))"
  echo $agenthost metrics[$item] $randNum >> /tmp/zdata.txt
done

# push all these trapper values back to zabbix
zabbix_sender -vv -z $zserver -p $zport -i /tmp/zdata.txt >> /tmp/zsender.log 2>&1

