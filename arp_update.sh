#!/bin/sh
#change *.*.*. to user local segment (192.168.*)
for a in `seq 1 254`; do ping -c 1 -w 0.5 *.*.*.$a > /dev/null && arp -a *.*.*.$a | grep ether; done
