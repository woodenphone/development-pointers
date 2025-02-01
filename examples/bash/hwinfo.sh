#!/bin/bash
## hwinfo.sh
echo "#[${0##*/}]" "Start" "$(date +@%s=%c)"
echo "#[${0##*/}]" "USER=$USER"
echo "#[${0##*/}]" "cansudo: $(sudo whoami)"
runname="hwinfo.$(hostname).$(date +%Y%m%dT%H%M%S%z)" # 20211205T181241+0000
#runname="hwinfo.$(hostname).$(date +@%s)" # @1638727972
#runname="hwinfo.$(hostname).$(date +%Ft%R)" # 2021-12-05t18:13
echo "#[${0##*/}]" "runname=$runname"
mkdir -vp "${runname}/" && cd "${runname}/"

echo "#[${0##*/}]" "Compute hardware"
sudo lscpu > "lscpu.$(hostname).$(date +@%s).txt"
sudo lsmem > "lsmem.$(hostname).$(date +@%s).txt"


echo "#[${0##*/}]" "General hardware info"
sudo lshw > "lshw.$(hostname).$(date +@%s).txt"
sudo lshw -short > "lshw-short.$(hostname).$(date +@%s).txt"
sudo lshw -html > "lshw.$(hostname).$(date +@%s).html"
sudo lspci > "lspci.$(hostname).$(date +@%s).txt"
sudo uname -a > "uname-a.$(hostname).$(date +@%s).txt"
sudo dmidecode > "dmidecode.$(hostname).$(date +@%s).txt"
hostname > "hostname.$(hostname).$(date +@%s).txt"

echo "#[${0##*/}]" "External devices"
sudo lsusb > "lsusb.$(hostname).$(date +@%s).txt"
sudo lsusb -v > "lsusb-v.$(hostname).$(date +@%s).txt"


echo "#[${0##*/}]" "Storage"
sudo lsblk > "lsblk.$(hostname).$(date +@%s).txt"
sudo lsblk -f > "lsblk-f.$(hostname).$(date +@%s).txt"
sudo lsblk -aO > "lsblk-aO.$(hostname).$(date +@%s).txt"
sudo lsblk -t > "lsblk-t.$(hostname).$(date +@%s).txt"
sudo fdisk -l > "fdisk-l.$(hostname).$(date +@%s).txt"


echo "#[${0##*/}]" "Network info"
sudo netstat -tunlp > "netstat-tunlp.$(hostname).$(date +@%s).txt"
sudo netstat --route > "netstat--route.$(hostname).$(date +@%s).txt"
sudo netstat --groups > "netstat--groups.$(hostname).$(date +@%s).txt"
sudo netstat --interfaces > "netstat--interfaces.$(hostname).$(date +@%s).txt"
sudo netstat --masquerade > "netstat--masquerade.$(hostname).$(date +@%s).txt"
sudo netstat --statistics > "netstat--statistics.$(hostname).$(date +@%s).txt"

sudo route > "route.$(hostname).$(date +@%s).txt"
sudo ifconfig > "ifconfig.$(hostname).$(date +@%s).txt"
sudo iptables --list > "iptables--list.$(hostname).$(date +@%s).txt"
sudo ip link show > "ip-link-show.$(hostname).$(date +@%s).txt"

curl 'ifconfig.co/json/' > "ifconfigco-json.$(hostname).$(date +@%s).json"
curl 'curl ifconfig.me' > "ifconfigme.$(hostname).$(date +@%s).txt"
curl 'curl ifconfig.me/all' > "ifconfigme-all.$(hostname).$(date +@%s).txt"
curl curl 'https://api.ipify.org?format=json' > "ipify.$(hostname).$(date +@%s).json"

echo "#[${0##*/}]" "Users"
sudo lslogins > "lslogins.$(hostname).$(date +@%s).txt"

echo "#[${0##*/}]" "Bundling files"
cd ..
tar -cvzf "${runname}.tar.gz" "${runname}/"

echo "#[${0##*/}]" "Finished" "$(date +@%s=%c)"
