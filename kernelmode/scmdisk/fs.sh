#!/bin/bash

mountpoint="/mnt/scmfs"
scmdevice0="/dev/scm0"
scmctldevice0="/dev/scm0-ctl"
objdir="build"

function mkfs {
	if [ ! -b "$scmdevice0" ]
	then 
	mknod $scmdevice0 b 240 0
	fi
	if [ ! -c "$scmctldevice0" ]
	then 
	mknod $scmctldevice0 c 241 0
	chmod a+wr $scmctldevice0
	fi
	/sbin/insmod $objdir/scmdisk.ko
	/sbin/mke2fs -m 0 /dev/scm0
	if [ ! -d "$mountpoint" ]
	then 
	mkdir $mountpoint
	fi
	mount /dev/scm0 /mnt/scmfs -o noatime,nodiratime
	chmod a+wr /mnt/scmfs
}

function rmfs {
	umount $mountpoint
	/sbin/rmmod scmdisk.ko
}

if [ "$1" = "-c" ]
then
mkfs
fi

if [ "$1" = "-r" ]
then
rmfs
fi
