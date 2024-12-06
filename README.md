# LFS
Linux From Scratch (LFS) Version 12.2  

## Entrer / Sortir de l'env chroot sur host

* Entrer dans l'env chroot
* Monter le system de partitions

1- Monter les partitions Linux Filesystem (/) et (/boot):  

`mount -v -t ext4 /dev/sdb4 $LFS`  
`mount -v -t ext4 /dev/sdb2 $LFS/boot`

2- Vérifier partition swap active:  

`/sbin/swapon -v /dev/sdb3`  

3- Montage de (/dev) et du Virtual Kernel File Systems

`mount -v --bind /dev $LFS/dev`  
`mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts`  
`mount -vt proc proc $LFS/proc`  
`mount -vt sysfs sysfs $LFS/sys`  
`mount -vt tmpfs tmpfs $LFS/run`  

`if [ -h $LFS/dev/shm ]; then`  
`  install -v -d -m 1777 $LFS$(realpath /dev/shm)`  
`else`  
`  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm`  
`fi`  

4- Entrer dans le chroot environment

`chroot "$LFS" /usr/bin/env -i   \`  
`    HOME=/root                  \`  
`    TERM="$TERM"                \`  
`    PS1='(lfs chroot) \u:\w\$ ' \`  
`    PATH=/usr/bin:/usr/sbin     \`  
`    MAKEFLAGS="-j$(nproc)"      \`  
`    TESTSUITEFLAGS="-j$(nproc)" \`  
`    /bin/bash --login`  
  
* Sortir de l'env chroot  
* Démonter le system de partitions  

1- Sortie de l'env  

`logout`  

Sortir du directory "/mnt/lfs"  

2- Démonter le system de fichier virtuel  

`umount -v $LFS/dev/pts`  
`mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm`  
`umount -v $LFS/dev`  
`umount -v $LFS/run`  
`umount -v $LFS/proc`  
`umount -v $LFS/sys`  

3- Démonter LFS filesystem et les autres partitions utilisées

`umount -v $LFS/boot`  
`umount -v $LFS`  

* cmd display virtual filesystem mount  

`(findmnt | grep /mnt/lfs)`  

## Structure partitions  

1- /dev/sdb1 (BIOS/GRUB) BIOS BOOT (code binaire de GRUB, démarrage du system, image initial de grub chargée dans le bios) 
1Mo  

2- /dev/sdb2 (/boot) LINUX FILESYSTEM (noyaux, autres fichiers nécessaires au démarrage du system) 200Mo  

3- /dev/sdb3 (swap) LINUX SWAP (swap space, decharge la RAM (mémoire vive physique = utilisée pour stocker des données en cours de traitement) le system va deplacer des pages mémoires vers swap afin de libérer de l'espace mémoire) 
8Go  

4- /dev/sdb4 (/)(racine) LINUX FILESYSTEM min 30Go  

* Commandes liée a la gestion des partitions  

`lsblk` = affiche tous les périphériques (disques et partitions)
`fdisk -l` =  list partitions
`mkfs -t ext4 /dev/sdb4` = créer un system de fichiers linux (-t précise le type ext2-ext3-ext4)  

## Configuration du System  

* Network Configuration  

* * /etc/sysconfig/ifconfig.eth0 >>  

`IFACE=enp0s3`  
`IP=10.0.2.15`  
`GATEWAY=10.0.2.2`  
`BROADCAST=10.0.2.255`  

* * DNS address >> /etc/resolv.conf >>

`domain lfs.com`  
`nameserver 8.8.8.8`  
`nameserver 8.8.4.4`  
(8.8.8.8 et 4.4 are Google Public IPv4 Domain Name Service address)  

* * Nom hote du system >> /etc/hostname 

`echo "name_hostsystem" > /etc/hostanme`

* * Fichier nom de domaine (FQDN) >> /etc/hosts  

`127.0.0.1 localhost.localdomain localhost`
`127.0.1.1 name_hostsystem.lfs.com name_hostsystem`  
`<10.0.2.15> name_hostsystem.lfs.com name_hostsystem` 

* System file Configuration (option du noyau Linux et GRUB) 

/etc/fstab = table de systeme de fichiers, où ils doivent étre montés et dans quel ordre.  
Suite configurer les options du noyau linux avec l'interface du menuconfig. Vers vmlinuz.  

* * config GRUB 

Installer GRUB en mode BIOS sur ton disque sdb:  
  
`grub-install --target=i386-pc /dev/sdb`  

file >> /boot/grub/grub.cfg >>  

`set root=(hd1,2)`  
`memuentry "GNU/Linux, Linux 6.10.5-name_version" {`    
`    linux   /vmlinuz-6.10.5-name_version root=/dev/sdb4 ro`    
`}`  

* Notes config  

* * Udev 
  
Gestion dynamique des périphériques dans le system. C'est une partie de systemd mais il peut étre installé independamment.  
Gestion des périphériques matériels en créant dynamiquement des fichiers de périphériques dans le répertoire /dev.  
Remplace la création statique de périphériques par une gestion dynamique. (créer uniquement les périphériques détectés et pas tous les périphériques pouvant exister)   
Simplifie la config des périphs via des régles de nommages et de permissions. (donne des noms plus significatifs aux peripheriques)(on peut aussi definir des permissions d'accées pour chaque périphérique aux users ou groups)   
Permet des actions automatisées lors de changements de matériels. (périphérique connecté ou deconnecté(usb peut monter un volume/périphérique réseau déclenche config réseau))    
  
* * GRUB  
  
(Grand Unified Bootloader) est un chargeur d'amorcage. Responsable du processus initial de démarrage d'un system.  
Ordi allumé => passe par séquence d'init du matériel (BIOS) qui recherche ensuite le chargeur d'amorcage (GRUB) pour lancer system d'exploitation.  
GRUB localise et charge le noyaux LINUX dans la RAM. Puis passe la main au noyau en lui fournissant les paramètres necessaire.  
GRUB permet le multi-boot, peut gérer plusieurs system d'exploitation sur le même disque dur.  
Flexible pour tester des configurations variées du noyau.  
Interface de récuperation en cas de problème.  
  
* * Script de démarrage  
  
SysVinit = gestionnaire de service UNIX/LINUX ou daemon manager (initialiser et gerer les services)  
Modèle d'initialisation basé sur des scripts et des niveaux d'executions, scripts de démarrage et execution sequentielle (ordre specifique d'execution).  
Simple et Leger mais manques de parallelisme et dependances limitées.  
  
SystemD = plus moderne, approche plus modulaire et orientée vers les dépendances pour gérer les services.  
Démarrage parallele. composants system definis par des unités permet un ciblage pour remplacer les niveaux d'exec de sysvinit.  
plus complexe et emprunte mémoire plus elevée.  
  
* * vmlinuz 
Noyau LINUX compilée et compressée, pret a étre chargée par le chargeur d'amorcage (GRUB) pour init le systeme. Contient code du noyau en format executable.  
  
* Commandes systems  
  
`locale -a` = liste tous les paramètres regionaux pris en charge par glibc  
`ip -a` = liste les interfaces reseaux  
`ip route` = check passerelle par default  

* Commandes debug  

`./configure > output.txt 2>&1` = redirige stdout et stderr de ./configure dans un file   
`./configure > stdout.txt 2> stderr.txt` = redirige les 2 sorties séparemment  
`./configure 2>&1 | tee output.txt` = redirige les sorties et les prints dans le terminal  
  
## System LFS up et fonctionnel  

* Commandes créations user no-root  

En tant que root user:  
`groupadd name_group`  
`useradd -s /bin/bash -g name_user -m`    
`passwd name_user`    

* root to user / user to root  

`su - name_user`  
`su - `    

* éteindre le system correctement  

`poweroff`  

* test network  

`ping -c 8.8.8.8`