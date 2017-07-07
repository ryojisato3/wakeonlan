#!/bin/sh
for a in `seq 1 254`; do ping -c 1 -w 0.5 192.168.6.$a > /dev/null && arp -a 192.168.6.$a | grep ether; done
