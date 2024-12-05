
# Filesystem Hierarchy Standard
[FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s04.html)  
  
## /bin Essential user command binaries  
contains commands that may be used by both the system administrator and by users,  
but which are required when no other filesystems are mounted.  
contains also commands wich are used indirectly by scripts.  
* CMDS requirements (3.4.2 in FHS) - list :  
cat - chgrp -chmod - chown - cp - date - dd - df - dmesg - echo - false - hostname  
kill - ln - login - ls - mkdir - mknod - more - mount - mv - ps - pwd - rm - rmdir  
sed - sh - stty - su - sync - true - umount - uname  
   
## /boot Static files of the boot loader   
everything required for the boot process except configuration files not needed at boot  
time and the map installer. /boot stores data that is used before the kernel begins executing user-mode programs.  
The operating system kernel must be located in either / or /boot.  
  
## /dev  
location of special or device files.  
/dev must contain a command named MAKEDEV, which can create devices as needed. It may also contain a MAKEDEV.local for any local devices.   
  
* /dev/tty -> This device is a synonym for the controlling terminal of a process.  
  
## /etc Host-specific system configuration   
/etc hierarchy contains configuration files. A "configuration file" is a local file used to  
control the operation of a program; it must be static and cannot be an executable binary.  
No binaries may be located under /etc.  
etc/opt -> configuration files for /opt  
  
## /home (optional) User home directories  
  
## /lib Essential shared libraries and kernel modules  
shared library images needed to boot the system and run the commands in the root filesystem by binaries in /bin and /sbin.  
  
## /lib<qual>(optional)  
variants of the /lib directory on systems which support more than one binary format requiring separate libraries.  
  
## /media Mount point for removable media  
used as mount points for removable media such as floppy disks, cdroms and zip disks.  
  
## /mnt Mount point for a temporarily mounted filesystem  
the system administrator may temporarily mount a filesystem as needed.  
This directory must not be used by installation programs.  
  
## /opt Add-on application software packages  
reserved for the installation of add-on application software packages.  
/opt/<package> - /opt/<provider> directory tree.  
<package> -> static package objects (software package).  
<provider> -> LANANA registered provider name.  
(<LANANA> = The authority responsible for assigning LINUX names and numbers))
/opt/bin, /opt/doc, /opt/include, /opt/info, /opt/lib, /opt/man are reserved for local system admin.   
  
## /root Home directory for the root user  
  
## /run Run-time variable data  
contains system information data describing the system since it was booted.  
Files under this directory must be cleared at the beginning of the boot process.  
/run should not be writable for unprivileged users.  
  
## /sbin System binaries  
Utilities used for system administration (and other root-only commands) are stored in /sbin, /usr/sbin, and /usr/local/sbin.  
/sbin contains binaries essential for booting, restoring, recovering, and/or repairing the system in addition to the binaries in /bin.  
There must be no subdirectories in /sbin.  
`shutdown` -> Command to bring the system down.  
lists :
fdisk - fsck - ifconfig - init - mkfs - mkswap - reboot - route  
ldconfig  
  
## /srv Data for services provided by this system  
/srv contains site-specific data which is served by this system.  
  
## /tmp Temporary files
The /tmp directory must be made available for programs that require temporary files.  
Programs must not assume that any files or directories in /tmp are preserved between invocations of the program.  
  
## /proc kernel and process information virtual filesystem  
standard Linux method for handling process and system information. 
  
## /sys kernel and system information virtual filesystem

## /usr hierarchy :
/usr is shareable, read-only data.  
  
### /usr/bin most user commands  
This is the primary directory of executable commands on the system.  
There must be no subdirectories in /usr/bin.  
  
### /usr/include directory for standard include files
contains all of the system's general-use include files for the C programming language.  
  
### /usr/lib libraries for programming and packages  
includes object files and libraries.  
  
### /usr/libexec (optional) Binaries run by other programs

### /usr/local local hierarchy  
use by the system administrator when installing software locally.  
  
### /usr/sbin non-essential standard system binaries
contains any non-essential binaries used exclusively by the system administrator.  
There must be no subdirectories in /usr/sbin.  
  
### /usr/share architecture-independent data  
is for all read-only architecture independent data files.  
Any program or package which contains or requires data that doesn't need to be modified should store that data in /usr/share.  
It is recommended that a subdirectory be used in /usr/share for this purpose.  
* /usr/share/man -> The primary <mandir> of the system is /usr/share/man. /usr/share/man contains manual information for commands and data under the / and /usr filesystems.  
* /usr/share/misc -> miscellaneous architecture-independent datadonnees (File : ascii)  
  
### /usr/src source code  
  
## /var hierarchy :
/var contains variable data files. This includes spool directories and files, administrative and logging data, and transient and temporary files.  
  
### /var/account process accounting logs (optional)  
  
### /var/cache application cache data  
The data must remain valid between invocations of the application and rebooting the system.  
The application must always be able to recover from manual deletion of these files.  
  
### /var/lib variable state information  
* /var/lib/misc  
  
### /var/local -> donnees variables pour /usr/local
  
### /var/lock lock files  
  
### /var/log log files and directories  

### /var/mail user mailbox files (optional)  
  
### /var/opt variable data for /opt
Variable data of the packages in /opt must be installed in /var/opt/<subdir>.  
  
### /var/run run-time variable data  
It is valid to implement /var/run as a symlink to /run.  
  
### /var/spool application spool data  
contains data which is awaiting some kind of later processing.  
often data is deleted after it has been processed.  
* /var/spool/cron -> cron and at jobs    
this directory contains the variable data for the cron and at programs.  
  
### /var/tmp temporary files preserved between system reboots  
   

# NOTES LFS  
[PARTITIONING FOR LFS](https://www.linuxfromscratch.org/hints/downloads/files/partitioning-for-lfs.txt)  

Recommandation :  
| MATERIEL HOST |  
* processeur du system => 4 coeurs + system au moins 8 Go de memoire  
  
| LOGICIEL HOST |  
Bash-3.2 (/bin/sh lien symbolique ou physique)  
Binutils-2.13.1  
Bison-2.7  
Coreutils-8.1  
Diffutils-2.8.1  
Findutils-4.2.31  
Gawk-4.0.1 (usr/bin/awk lien vers gawk)  
GCC-5.2  
Grep-2.5.1a  
Gzip-1.3.12  
Noyau Linux-4.19  
M4-1.4.10  
Make-4.0  
Patch-2.5.4  
Perl-5.8.8  
Python-3.4  
Sed-4.1.5  
Goudron-1,22  
Texinfo-5.0  
Xz-5.0.0  
  
I - Preparing the host system  
| Creating a new partition |  
either empty partition available or there is sufficient unpartitioned space.  
min 10 Go - 30 Go recommended size  
partition program for hardisk `cfdisk` ou `fdisk`   
  
    The LFS root partition -  
(not to be confused with /root directory) 20 Go  
  
    Swap partition -  
RAM available for compilation processes -> use swap partition  
2 Go - the swap partition must be at least as large as the RAM installed on the system. in case of prolonged extinction.  
  
    Bios Grub partition -  
1 Mo partition must be created not formatted for installing bootloaders.  
name = "BIOS Boot" for fdisk or code EF02 for gdisk.  
  
    Convenience partitions -  
    - /boot - 200 Mo
partition to store kernels and other boot info. 1st physical partition of your 1st disk drive.  
    - /boot/efi  
EFI system partition needed to boot system with UEFI for BLFS.  
    - /home - very recommended  
    - /usr -  
/bin, /lib, /sbin sont des liens symbolique vers leurs homologue dans /usr  
    - /opt - useful fot BLFS - 5-10 Go  
    - /tmp  
    - /usr/src 30 - 50 Go  
utility partition to store BLFS src files and share them between LFS builds.  
  
| Creating a file system on a partition |  
Partitions = series of sectors on a hard disk, delimited by a partition table.  
Before use, the partition must be formatted to contain a file system.  
LFS can use any file system recognized by the Linux kernel. But the most common types are:  
ext3 or ext4.  
Other systems exist like FAT32 / NTFS / JFS / XFS.  
  
| Set var $LFS |  
`export LFS=/mnt/lfs`  
/!\ CHECK regularly that the variable LFS is well defined in the directory with -> `echo $LFS`  
  
| Mount new partition |  
`mkdir -pv $LFS`  
`mount -v -t ext4 /dev/<name_partition_lfs> $LFS`  
if many partitions /home plus LFS  
`mkdir -pv $LFS`  
`mount -v -t ext4 /dev/<xxx> $LFS`  
`mkdir -v $LFS/home`  
`mount -v -t ext4 /dev/<yyy> $LFS/home`  
  
| Package sources |  
$LFS/sources can be used as a storage location for tarballs and patches and as a working directory.  
-> this directory must be writable and permanent, means that even if several users have write permission on a directory only the owner can delete it.  
If sources download as a non-root user, these files will be owned by the user.  
`chown root:root $LFS/sources/*`  

| SBU |    
Standard Build Unit (SBU) measurement  
The time taken to compile using a single core is what we let's call it the Standard Compilation Unit or SBU.
  
II - Creation of the LFS cross-tool chain and temporary tools  
- stage 1 - cross-compiler construction and its associated libraries;  
- stage 2 - use of this cross-toolchain to create several utilities in order to isolate them from the host distribution;  
- stage 3 - entry into chroot environment (improved host isolation) and construction of tools necessary for the final system.  
-> anything that is cross-compiled cannot depend on the host env.  
  
The build, machine where we build programs or host.  
The host, machine/system where the build programs will run.  
The target, use for compiler, this is the machine for which the compiler produces the code.  
  