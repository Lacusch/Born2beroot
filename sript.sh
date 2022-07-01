#/!bin/bash

wall "#Architecture: $(uname -a) #CPU physical: $(nproc --all) #vCPU: $(grep processor /proc/cpuinfo | wc -l)
#Memory Usage: $(free --human | awk '/^Mem/ {printf "%s/%s (%.2f %%)", $3, $2, $3/$2*100}')
#Disk Usage: $(df --human-readable / /var /srv /home /tmp /var/log --total | awk '/^total/ {printf "%s/%s (%.2f %%)", $3,$2,$3/$2*100}')
#CPU load: (utilisation rate of processor/processors): $(top -bn1 | awk '/Cpu/ {printf "%.1f %%", $2}')
#Last boot: $(who --boot | awk '{print $3,$4}')
#LVM use: $(lsblk -o type | grep lvm | sort -u | awk '{if ($1) {print "yes"} else {print "no"}}')
#Connections TCP: $(cat /proc/net/snmp |grep Tcp |grep -v RtoAlgorithm |awk '{printf "%s ESTABLISHED", $10}')
#User log: $(who | cut -d ' ' -f 1 | sort -u | wc -l)
#Network: IP $(hostname -I) ($(ip link | grep ether | awk '{print $2}'))
#Sudo: $(cat /var/log/sudo/sudo_log |wc -l) cmd
"
