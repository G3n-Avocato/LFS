# ft_linux
Linux From Scratch (LFS) Version 12.2  

## Entrer / Sortir de l'env chroot sur host

* Entrer dans l'env chroot
* Monter le system de partitions

1- Monter les partitions Linux Filesystem (/) et (/boot):  

`mount -v -t ext4 /dev/sdb4 $LFS`  
`mount -v -t ext4 /dev/sdb2 $LFS/boot`

2- Verifier partition swap active:  

`/sbin/swapon -v /dev/sdb3`  

3- Montage de (/dev) et du Virtual Kernel File Systems

`mount -v --bind /dev $LFS/dev`
`mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run`

`if [ -h $LFS/dev/shm ]; then
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi`

4- Entrer dans le chroot environment

`chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login`

* Sortir de l'env chroot  
* Demonter le system de partitions  

1- Sortie de l'env  

`logout`  

Sortir du directory "/mnt/lfs"  

2- Demonter le system de fichier virtuel  

`umount -v $LFS/dev/pts  
mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm  
umount -v $LFS/dev  
umount -v $LFS/run  
umount -v $LFS/proc  
umount -v $LFS/sys`  

3- Demonter le LFS filesystem et les autres partitions utilisee

`umount -v $LFS/boot  
umount -v $LFS`  

* Commandes liee a la gestion du filesystem virtuel  

`findmnt | grep /mnt/lfs`  

## Structure partitions  

1- /dev/sdb1 (BIOS/GRUB) BIOS BOOT (code binaire de GRUB, demarrage du system, image initial de grub chargee dans le bios) 
1Mo  

2- /dev/sdb2 (/boot) LINUX FILESYSTEM (noyaux, autres fichiers necessaires au demarage du system) 200Mo  

3- /dev/sdb3 (swap) LINUX SWAP (swap space, decharge la RAM (memoire vive physique = utiliser pour stocker des donnees en cours de traitement) le system va deplacer des pages memoires vers swap afin de liberer de l'espace memoire) 
8Go  

4- /dev/sdb4 (/)(racine) LINUX FILESYSTEM min 30Go  

* Commandes liee a la gestion des partitions  

`lsblk` = affiche tous les peripheriques (disques et partitions)
`fdisk -l` =  list partitions
`mkfs -t ext4 /dev/sdb4` = creer un system de fichiers linux (-t precise le type ext2 ext3 ext4)  

## Configuration du System  

* Network Configuration  

* * /etc/sysconfig/ifconfig.eth0 >>  

`IFACE=enp0s3  
IP=10.0.2.15  
GATEWAY=10.0.2.2  
BROADCAST=10.0.2.255`  

* * DNS address >> /etc/resolv.conf >>

`domain lfs.com    
nameserver 8.8.8.8  
nameserver 8.8.4.4`  
(8.8.8.8 et 4.4 are Google Public IPv4 Domain Name Service address)  

* * Nom hote du system >> /etc/hostname 

`echo "name_hostsystem" > /etc/hostanme`

* * Fichier nom de domaine (FQDN) >> /etc/hosts  

`127.0.0.1 localhost.localdomain localhost  
127.0.1.1 name_hostsystem.lfs.com name_hostsystem  
<10.0.2.15> name_hostsystem.lfs.com name_hostsystem` 

* System file Configuration (option du noyau Linux et GRUB) 

/etc/fstab = table de systeme de fichiers, ou ils doivent etre montes et dans quel ordre.  
Suite configurer les options du noyau linux avec l'interface du menuconfig. Vers vmlinuz.  

* * config GRUB 

Installer GRUB en mode BIOS sur ton disque sdb:  
  
`grub-install --target=i386-pc /dev/sdb`  

file >> /boot/grub/grub.cfg >>  

`set root=(hd1,2)  
memuentry "GNU/Linux, Linux 6.10.5-name_version" {  
    linux   /vmlinuz-6.10.5-name_version root=/dev/sdb4 ro  
}`  

* Notes config  

* * Udev 
  
Gestion dynamique des peripheriques dans le systeme. C'est une partie de systemd mais il peut etre installee independamment.  
Gestion des peripheriques materiels en creant dynamiquement des fichiers de peripheriques dans le repertoire /dev.  
Remplace la creation statique de peripheriques par une gestion dynamique. (creer uniquement les peripheriques detectee et pas tous les peripheriques pouvant exister)   
Simplifie la config des periphs via des regles de nommages et de permissions. (donne des noms plus significatifs qux peripheriques)(on peut aussi definir des permissions d'acces pour chaque peripherique aux users ou groups)   
Permet des action automatisees lors de changements de materiels. (peripherique connecte ou deconnectee(usb peut monter un volume/peripherique reseau declenche config reseau))    
  
* * GRUB  
  
(Grand Unified Bootloader) est un chargeur d'amorcage. Responsable du processus initial de demarrage d'un systeme.  
Ordi allumer => passe par sequence d'init du materiel (BIOS) qui recherche ensuite le chargeur d'amorcage (GRUB) pour lancer system d'exploitation.  
GRUB localise et charge le noyaux LINUX dans la RAM. Puis passe la main au noyau en lui fournissant parametre necessaire.  
GRUB permet le multi-boot peut gerer plusieurs system d'exploitation sur le meme disque dur.  
Flexible pour tester des configurations variees du noyau.  
Interface de recuperation en cas de probleme.  
  
* * Script de demarrage  
  
SysVinit = gestionnaire de service UNIX/LINUX ou daemon manager (initialiser et gerer les services)  
Modele d'initialisation basee sur des scripts et des niveaux d'executions, scripts de demarrage et execution sequentielle (ordre specifique d'execution).  
Simple et Leger mais manques de parallelisme et dependances limitees.  
  
SystemD = plus moderne, approche plus modulaire et orientee vers les dependances pour gerer les services.  
Demarrage parallele. composants system definis par des unites permet un ciblage pour remplacer les niveaux d'exec de sysvinit.  
plus complexe et emprunte memoire plus elevee.  
  
* * vmlinuz 
Noyau LINUX compilee et compressee, pret a etre chargee par le chargeur d'amorcage (GRUB) pour init le systeme. Contient code du noyau en format executable.  
  
* Commandes systems  
  
`locale -a` = liste tous les parametres regionaux pris en charge par glibc  
`ip -a` = list les interfaces reseau  
`ip route` = check passerelle par default  

## System LFS lancee et fonctionnel  

* Commandes creations user no-root  

En tant que root user:  
`groupadd name_group`  
`useradd -s /bin/bash -g name_user -m`    
`passwd name_user`    

* root to user / user to root  

`su - name_user`  
`su -  
passwd:`  

* eteindre le system correctement  

`poweroff`  

* test network  

`ping -c 8.8.8.8`