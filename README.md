# Born2beroot
This project required you to set up a debian virtual mashine and get into the basics of system administration.
A requirement for this was to create a monitoring strip to show some required info about thi system.
This README is just a quick explanation of the script and what each line does.

## Explanations:
This script is using awk to achieve more advanced options, this section
provides only the bare basics, to learn more try to run only some parts 
of the commands to understand it, or learn more at man awf, so RTFM ;)

Partly/Mostly based on a script created by AnniYuko, with the goal of
explaning what each command does [origial repo](https://github.com/AnniYuko/42cursus/tree/main/born2beroot).
### List system Architecture:
`$uname -a`
### Lists physical CPU cores:
`$(uname -a)`

### List virtual CPU-s (vCPU):
`$(grep processor /proc/cpuinfo | wc -l)`

### Memory Usage:
This part uses free to get the memory usable by the system ,pipes
it into awk, which processes the line with Mem in it, then prints
free/used memory, then uses division to get the % of the memory used
according to The `$2` and `$3` so the 2. and 3. Strings respectively
```
$(free --human | awk '/^Mem/#Explanations:
{printf "%s/%s (%.2f %%)", $3, $2, $3/$2*100}')
```

### Disk Usage:
Scannes the available space on each given file system, then prints the total amount in a human readable format. This gets processed by awk to
Print the desired output
```
$df --human-readable / /var /srv /home /tmp /var/log --total
 | awk '/^total/ {printf "%s/%s (%.2f %%)", $3,$2,$3/$2*100}')
```

### CPU load:
Uses system monitor top to get a bunch system information then gets the
Line containing the Cpu info and prints it.
`(top -bn1 | awk '/Cpu/ {printf "%.1f %%", $2}')`

### Last boot:
Gets the last boot time using boot, then prints the
required lines using awk
`$(who --boot | awk '{print $3,$4}')`

### LVM use:
Checks it you're using LVM or not. It list the file partition
structure, checks the results with grep and then prints yes it an LVM
volume exits
```
(lsblk -o type | grep lvm | sort -u | awk '{if ($1) {print "yes"} else {print "no"}}')
```
### Connections TCP:
Searches the :cat /proc/net/snmp for the network info,
looking for the lines starting with Tcp, then prints int to std.
`$(awk 'BEGIN{ORS=" "} /^Tcp/ {print $10}' /proc/net/snmp)`

### User log:
Shows the users logged in, eliminates duplicates, then counts
the words to get a final amount
`$(who | cut -d ' ' -f 1 | sort -u | wc -l)`

### Network:
Prints the private ip (The one I'm using for SSH), then looks
Up the MAC address, looks for the line with Ethernet, then prints the id
`$(hostname -I) (MAC address: $(ip link | grep ether | awk '{print $2}'))`

### Sudo:
Looks for sudo log file (This could be different that mine), then
uses wc to count the lines.
`$(cat /var/log/sudo/sudo_log | wc -l)`
