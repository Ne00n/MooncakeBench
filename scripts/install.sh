#!/bin/bash
#Check for Root
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
#Check OS
if [ -f "/etc/debian_version" ]; then
  apt-get -yqq install curl cron gawk
else
  echo "OS not supported";
  exit 1
fi
#Install
mkdir /opt/mooncake/
cd /opt/mooncake/
useradd mooncake -r -d /opt/mooncake -s /bin/false
#Fetch Agent
if [ -f "/etc/debian_version" ]; then
  curl https://raw.githubusercontent.com/Ne00n/MooncakeBench/master/scripts/debian/agent.sh --output agent.sh
fi
sed -i "s/token='INSERT_KEY_HERE'/key='${1}'/g" agent.sh
chown -R mooncake:mooncake /opt/mooncake/
chmod -R 700 /opt/mooncake/
#Install Cron
crontab -u mooncake -l 2>/dev/null | { cat; echo "*/1 * * * *  bash /opt/mooncake/agent.sh > /dev/null 2>&1"; } | crontab -u mooncake -
cd
rm install.sh
echo "Installed";
