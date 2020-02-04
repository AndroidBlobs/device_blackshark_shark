#! /vendor/bin/sh

# OPT is sdcard_dump_enable or sdcard_dump_disable
OPT=$1
DATE=`date +%Y%m%d_%H%M%S`
mkdir -p /data/vendor/bslogs/ramdump
mount -t vfat -o noatime /dev/block/bootdevice/by-name/ramdump /data/vendor/bslogs/ramdump
if [ $? -ne 0 ]; then
# sectors=9G=2359296 = 9*1024*1024*1024/4096  bps=4096
RDPartitionStr=`cat /proc/partitions | grep sda13`
RDSize=`expr ${RDPartitionStr:13:11} \* 1024 / 4096`
# sectors=RDSize*1024/4096
/system/bin/newfs_msdos -F 32 -s $RDSize /dev/block/bootdevice/by-name/ramdump
mount -t vfat -o noatime /dev/block/bootdevice/by-name/ramdump /data/vendor/bslogs/ramdump
elif [ ! -f /data/vendor/bslogs/ramdump/ram_dump/first_launch ]; then
rm -rf /data/vendor/bslogs/ramdump/ram_dump
rm -rf /sdcard/ramdump
fi

mkdir -p /data/vendor/bslogs/ramdump/ram_dump
touch /data/vendor/bslogs/ramdump/ram_dump/first_launch
touch /data/vendor/bslogs/ramdump/ram_dump/pstore.txt

mkdir -p /data/vendor/bslogs/pstore
cat /dev/block/bootdevice/by-name/pstore > /data/vendor/bslogs/pstore/ramoops

mkdir -p /sdcard/ramdump
cat /dev/block/bootdevice/by-name/pstore > /sdcard/ramdump/pstore_full_$DATE.txt

for i in 1 2 3
do
if [ -d /data/vendor/bslogs/ramdump/ram_dump/$i ]&&[ "`ls /data/vendor/bslogs/ramdump/ram_dump/$i`" != "" ];then
echo 0000$i
cp -rf /data/vendor/bslogs/ramdump/ram_dump/$i /sdcard/ramdump/
cp -f /data/vendor/bslogs/ramdump/ram_dump/pstore.txt /sdcard/ramdump/pstore_$DATE.txt
cp -f /data/vendor/bslogs/ramdump/ram_dump/pstore.txt /data/system/dropbox/pstore_$DATE.txt
cp -f /data/vendor/bslogs/ramdump/ram_dump/pstore.txt /sdcard/ramdump/$i/pstore_$DATE.txt
rm -rf /data/vendor/bslogs/ramdump/ram_dump/$i/*
if [ $i == "3" ];then
cd /data/vendor/bslogs/ramdump/ram_dump/
rm -rf 1 2 3 4
fi
fi
done
