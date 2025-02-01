#!bash
## stats.sh
log='stats.log'
echo "## == Start log entry ==" | tee -a $log
echo "#> localtime=`date`" | tee -a $log
echo "#> utctime=`date -u`" | tee -a $log
echo "#> unixtime=`date -u +%s`" | tee -a $log
echo "#> uptime=`uptime`" | tee -a $log
echo "#> hostname=`hostname`" | tee -a $log
echo "#> USER=$USER" | tee -a $log
echo "#> PWD=$PWD" | tee -a $log

echo '#$ ls -lahQ $PWD' | tee -a $log
ls -lahQ $PWD | tee -a $log

echo '#$ df -hT -xtmpfs -xdevtmpfs -xsquashfs -xoverlay' | tee -a $log
df -hT -xtmpfs -xdevtmpfs -xsquashfs -xoverlay | tee -a $log

echo '#$ lsblk -o "NAME,FSTYPE,LABEL,MODEL,SERIAL,SIZE"' | tee -a $log
lsblk -o "NAME,FSTYPE,LABEL,MODEL,SERIAL,SIZE" | tee -a $log

echo "#> unixtime_du_pre=`date -u +%s`" | tee -a $log
echo '#$ du -hd1 $PWD' | tee -a $log
du -hd1 $PWD | tee -a $log
echo "#> unixtime_du_post=`date -u +%s`" | tee -a $log

echo "#> unixtime_end=`date -u +%s`" | tee -a $log
echo "## == end log entry ==" | tee -a $log
