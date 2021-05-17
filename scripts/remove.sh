#!/bin/bash
pkill -u mooncake
userdel mooncake
rm /var/spool/cron/crontabs/mooncake
rm -r /opt/mooncake/
