#!/bin/bash
token='INSERT_KEY_HERE';
version='0.1';

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then
    echo "This script is already running with PID `pidof -x $(basename $0) -o %PPID`"
else

virtualization=$(systemd-detect-virt);
operatingSystem=$(cat /etc/debian_version);
processor=$(cat /proc/cpuinfo);
gateway=$(ip route get 8.8.8.8  | head -n1 | cut -d " " -f3);
memory=$(grep MemTotal /proc/meminfo | awk '{print $2;}');
disk=$(df -h | awk '/\/$/');
load=$(top -bn2 -b | awk '/^%Cpu/');
google=$(mtr 8.8.8.8 --report);
cloudflare=$(mtr 1.1.1.1 --report);

curl --connect-timeout 30 --max-time 30 -d "token=${token}&virtualization=${virtualization}&operatingSystem=${operatingSystem}&processor=${processor}&gateway=${gateway}&memory=${memory}&disk=${disk}&load=${load}&google=${google}&cloudflare=${cloudflare}&version=${version}" https://api.mooncake.local/drop/

fi
