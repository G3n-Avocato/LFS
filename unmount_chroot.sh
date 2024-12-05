#!/bin/bash

cd $HOME

export LFS="/mnt/lfs"

pwd
echo $LFS

umount -v $LFS/dev/pts
mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys

umount -v $LFS/boot
umount -v $LFS

echo "check unount LFS"
(findmnt | grep $LFS)