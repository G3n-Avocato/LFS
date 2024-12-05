
#Filesystem Hierarchy Standard
[FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s04.html)  
  
##/bin
commande qui peuvent a la fois etre utiliser par admin
et par user. Mais necessaires lorsque aucun system de fichier
n'est montee.  

les cmds 3.4 sont obligatoires 
/boot
tout ce qui est necessaire au proscessus de demarrage
a l'exception des fichiers de configurations non necessaires
au demarrage et a l'installateur de cartes.
stock data utilisees avant que le noyaux commence a executer
les programmes en mode utilisateur.

/dev
emplacement des fichiers speciaux ou des fichiers de peripheriques
contenir cmd MAKEDEV qui cree des peripheriques selon les besoins
MAKEDEV.local pour peripheriques locaux.
/dev/null -> condition EOF
/dev/zero -> source de donnees mise a zero
/dev/tty -> terminal de ctrl d'un proscessus 

/etc
fichiers de configuration -> c'est un fichier local utilise pour
controler le fonctionnement d'un programme.
Doit etre static et ne peut etre un binaire executable.
Recommandee de stocker fichiers dans sous-repertoire.
3.7 opter obligatoire.
etc/opt -> fichier de configuration pour /opt.
les fichiers de configurations specifiques a l'hote pour les
packages de logiciels d'appl complementaires doivent etre 
installees dans le repertoire /etc/opt/<subdir>>
COnfiguration particuliere pour windows.

/home (facultatif)
repertoire personnels des users.

/lib
bibliotheque partagees essentielles et modules du noyaux.
repertoire contenant les images de la bibliotheques partagee
necessaires pour demarrer le systeme et executer les cmds dans
le systeme de fichiers racine, par les binaires /bin et /sbin.

/lib<qual>(facultatif)
bibliotheque partagees essentielles (format alternatif)
prennent en charge plusieurs formats binaires.

/media
point de montage pour les supports amovibles.
contient des sous-repertoires utilises comme pts de montage
pour les supports amovibles tels que les disquettes cd-rom et diques zip.

/mnt
pts de montage pour un system de fichier montee temporairement
par un admin system selon besoins. ne doit pas etre utilisee 
pour les programmes d'installation.

/opt
reservee a l'installation de packages de logiciels d'appl complementaire.
/opt<package> /opt/<provider> directory tree.
<package> -> static package objects (software package).
<provider> -> LANANA registered provider name. le nom du fournisseur LSB attribuee par <LANANA>
(<LANANA> = L'autorite chargee de l'attribution des noms et numeros LINUX)
/bin, /doc, /include, /info, /lib, /man sont reserves a l'admin
dans le repertoire otp. 

/root
repertoire personnel user root

/run
ce repertoire continet des donnees d'information system decrivant le system 
depuis sont demarrage. les fichiers de se repertoire doivent etre efface au debut 
du proscessus de demarrage.
ne peut pas etre accessible en ecriture aux users non privilegies.

/sbin 
binaire system.
les utilitaires utilisees pour l'administration du systeme sont stockes
dans /sbin. Il contient les binaires essentiels au demarrage, a la recuperation 
et le reparation du system. En plus des binaire de /bin.
Aucun sous-repertoire dans /sbin.
cmd -> shutdown (cmd pour system down)

/srv 
donnees specifiques au site qui sont fournies par ce systeme.

/tmp 
fichiers temporaires doit etre rendu disponible pour les programmes 
necessitent des fichiers temporaires. Les progrs ne doivent pas suposer
que les fichiers ou rep sont conserves entre les appels du program.

/proc 
system de fichier virtuel contennat des infos sur le noyaux et les proscessus

/sys

/usr hierarchie :
donnes partageables en lecture seule.

/usr/bin -> les cmds user 
aucun sous repertoire. 

/usr/include -> repertoire pour fichiers d'include standard
pour langage programmation C.

/usr/lib -> lib 
inclu fichier object et bibliotheques

/usr/libexec (faculattif) -> binaires exec par d'autre program.

/usr/local -> hierarchie locale 
use by admin system pour installation locale de logiciels.

/usr/sbin -> binaire system non vitaux
aucun sous repertoire dans /usr/sbin.

/usr/share -> donnees independantes de l'architecture.
tout program ou package qui contient ou requiert des donnees qui 
n'ont pas besoin d'etre modifiees doit stocker ces donnees dans 
/usr/share avec un sous repertoire.

/usr/share/man -> manuels en ligne.

/usr/share/misc -> donnees diverses independantes de l'architecture
-> ascii

/usr/src -> code source uniquement a des fins de reference

/var hierarchie :
contient fichiers de donnees variables. inclut spool. donnees admin et 
journalistaion (log), fichiers transitoire et temporaires.
/var/account -> 

/var/cache -> donnees du cache d'application.
les donnees doivent rester valides entre les appels de l'app et le redemarrage du system.
l'app doit etre capable de recuperer apres la suppression manuelle de ces fichiers.

/var/lib -> information sur l'etat variables

/var/lib/misc -> donnees diverse sur l'etat

/var/local -> donnees variables pour /usr/local

/var/lock -> verouiller les fichiers 
fichiers de verouillage pour peripheriques.

/var/log -> fichiers journaux et repertoires

/var/log/lastlog, /messages, /wtmp

/var/opt -> donnees variable pour /opt

/var/run -> donnees pertinentes pour les proscessus en cours d'execution.
lien symbolique vers /run

/var/spool -> donnees de la bobine d'appl,
donnees qui attendent un traitement ulterieur. suppr apres avoir ete traitee.

/var/spool/cron -> tache cron et at 

/var/tmp -> fichier temporaires conserves entre les redemarrages du systeme

https://www.gnu.org/software/automake/manual/html_node/index.html#SEC_Contents
autotools: 
Automake outil permettant de generer automatiquement des Makefiles
GNU Build System 
prefix = /usr/local 
DESTDIR=$HOME -> l'installation sera redirigee

https://www.linuxfromscratch.org/lfs/view/stable/index.html

système LFS -> LINUX FROM SCRATCH

guide pratique de creation de logiciel => https://tldp.org/HOWTO/Software-Building-HOWTO.html

guide pratique de creation de logiciel a partir du code source => https://moi.vonos.net/linux/beginners-installing-from-source/

partition pour LFS => https://www.linuxfromscratch.org/hints/downloads/files/partitioning-for-lfs.txt


Recommandation :
| MATERIEL |
* processeur du system => 4 coeurs + system au moins 8 Go de memoire

| LOGICIEL |
(en-tete logiciels dans paquets separes sous forme de <package-name>-devel ou -dev)

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

LFS -> construit en une seul session
chap 1 a 4 -> exec sur system hote, lors du redemarrage -> les procedures root apres section 2.4 doivent avoir la var LFS set pour ROOT user
chap 5 a 6 -> /mnt/lfs partition montee
-> fait en tant que user lfs -> su -lfs cmd doit etre exec avant d'exec n'importe qu'elle tache sur ce chap sinon risque d'installer paquet sur hote 


I - Preparation du systeme hote 
| Creation d'une nouvelle partition |
soit partition vide disponible soit creer une si on dispose de suffisamment d'espace non partitionnee
min 10 Go - 30 Go taille recommandee 
memoire vive RAM disponible pour les processus de compilation -> use swap partition  
programme de partition de disk <cfdisk> ou <fdisk> 

    La partition racine LFS -
(ne pas confondre avec /root repertoire) 20 Go 

    La partition Swap -
2 Go - si use fct mise en veille prolongee de LINUX la partition swap doit etre au moins aussi grande que la RAM installe sur le system 

    La partition Bios de Grub -
if disk de demarrage a ete partitionne avec une table de partition GUID, partition de 1 Mo doit etre cree pas formatee -> 
pour installation des chargeur de demarrage. name = "BIOS Boot" pour fdisk ou code EF02 pour gdisk

    Cloisons de commodite - 
    - /boot - tres recommandee
partition pour stocker les noyaux et autres infos de demarrage. 1er partition physique de votre 1er lecteur de disk.
200 Mo
    - /boot/efi
partition system EFI necessaire pour demarrer system avec UEFI pour BLFS
    - /home - tres recommandee
partager votre repertoire personnel et vos personnalisations user sur +sieurs distri ou builds LFS - taille importante depende de l'espace disk disponible
    - /usr - possible pas necessaire
/bon, /lib, /sbin sont des liens symbolique vers leurs homologue dans /usr 
/usr contient tous les binaires necessaires au fonctionnement du system 
    - /opt - util pour BLFS - 5 a 10 Go
    - /tmp 
partition tmpfs pour accelerer acces au fichiers temporaires 
    - /usr/src 
partition util pour stocker les fichiers src BLFS et les partager entre les builds LFS 30 a 50 Go

| Creation d'un file system sur une partition |

Partitions serie de secteurs sur un disque dur, delimite par une table de partition.
Avant utilisation, la partition doit etre formatee pour contenir un systeme de fichiers.
LFS peut utiliser n'importe qu'elle system de fichier reconnu par le noyaux Linux. Mais types les plus courants sont :
ext3 et ext4. Choix depend des caracteristiques des fichiers et de la tailles des partitions.
D'autres system existe comme FAT32 / NTFS / JFS / XFS.

| Set var $LFS |
definie sur le nom du repertoire dans lequel vous allez construire votre system LFS.
EX : `export LFS=/mnt/lfs`
/!\ VERIFIER regulierement que la LFS variable est bien definie sur le repertoire avec ->
`echo $LFS`

| Montage de la nouvelle partition |
system de fichier cree, partition doit etre montee pour que le system hote puisse y acceder.
en realite on monte le system de fichier integrer dans la partition
`mkdir -pv $LFS`
`mount -v -t ext4 /dev/<name_partition_lfs> $LFS`
if plusieurs partition /home et LFS
`mkdir -pv $LFS`
`mount -v -t ext4 /dev/<xxx> $LFS`
`mkdir -v $LFS/home`
`mount -v -t ext4 /dev/<yyy> $LFS/home`

verifier que les partitions sont pas montees avec des restrictions trop importante (nosuid et nodev)
mount pour verfier restrictions, si pb remonter la partition.

2 - Package et Patch
Necessaires pour construire un system Linux de base.
$LFS/sources peut-etre utilisee comme emplacement de stockage des archives tar et des correctifs et comme repertoire de travail.
avant de demarrer session de telechargement et en tant que user root ->
`mkdir -v $LFS/sources`
-> ce repertoire doit etre accessible en ecriture et "Permanent"=signifie que meme si 
+sieurs user ont l'autorisation d'ecriture sur un repertoire seul le proprio peut suppr le fichier ans un repertoire permanent.
`chmod -v a+wt $LFS/sources`

Il y a +sieurs facon d'obtenir ces packages et correctifs pour creer LFS :
* telecharger individuellement
* archive tar de tous les fichiers necessaires peut etre telecharger sur les sites miroirs de LFS
* fichier peuvent etre telecharger avec wget ->
`wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources`
md5sums = fichier utiliser pour verifier packge correct avant de continuer

si fichier telecharger en tant que user non root, ces fichiers seront la propriete de l'utilisateur.
les fichiers resteront la propriete d'un UID sans nom, cmd ->
`chown root:root $LFS/sources/*`

/!\ ALL PACKAGE LINK /!\
https://www.linuxfromscratch.org/lfs/view/stable/chapter03/packages.html
517 Mo 
Correctif :
https://www.linuxfromscratch.org/lfs/view/stable/chapter03/patches.html

3 - Derniere prepa
creer un ensemble de repertoire $LFS(installation d'outils temporaire),
ajouter un user non privilegier et creer un env de construction approprie pour cet user
unite de temps <SBU> utile pour mesurer le tps de construction des paquets LFS.

* Creation d'une hierarchie de repertoire limitee pour futur program 

root => `mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

        for i in bin lib sbin; do
          ln -sv usr/$i $LFS/$i
        done

        case $(uname -m) in
          x86_64) mkdir -pv $LFS/lib64 ;;
        esac`

Cross-compiler installed in a special directory, separee des autres programmes ->
`mkdir -pv $LFS/tools`
ce repertoire ne doit pas exister dans la creation de LFS -> "/usr/lib64"

* Ajouter LFS User 
paquer des 2 prochains chap telechargee en tant que user non privilegiee.
creation user <lfs> membre du nouveau groupe <lfs>

root => `groupadd lfs`
        `useradd -s /bin/bash -g lfs -m -k /dev/null lfs`

-s /bin/bash => bash shell par default pour user lfs
-g lfs => option ajoute user lfs au groupe lfs 
-m => creer repertoire perso pour lfs 
-k /dev/null => empeche copie de fichier a partir d'un repertoire squelette
 
 definir un mot de pass pour lfs =>
 `passwd lfs`

 donner un acces complet a lfs =>
        `chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
        case $(uname -m) in
          x86_64) chown -v lfs $LFS/lib64 ;;
        esac`

`fg` en cas de probleme 
sinon `su - lfs`

* configuration environnement 

creer un bon environnement de travail vide en remplacant le shell en cours d'exec.
evite que des variables dangereuse du system hote s'infiltre dans l'installation.
`cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF`

creer le fichier .bashrc => 
` cat > ~/.bashrc << "EOF"
set +h                  # desactive fct de hachage de bash # lui demande de rechercher les nouveaux PATH pour qu'il oublie les anciens # 
umask 022               # def du mask de crea de fichier user # fichier et rep accessible en ecriture que par proprio mais lisible et exec par les autres #
LFS=/mnt/lfs            # def sur le pts de montage #
LC_ALL=POSIX            # controle la localisation de certain program # dans environnement de compilation croisee #
LFS_TGT=$(uname -m)-lfs-linux-gnu       # def une description de machine compatible pour compilateur croisee #
PATH=/usr/bin		# path var standard pour env #
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi	# if /bin not a symbolic link, add to PATH #
PATH=$LFS/tools/bin:$PATH			# rapel au shell d'utiliser compilateur croisee au lieu de compilateur hote #
CONFIG_SITE=$LFS/usr/share/config.site	# rappel pour eviter de charger des elements de configuration du system hote # 
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE	# pour qu'ils soient visibles dans tous les sous-shell #
EOF `

Option de ligne de commande make pour preciser au makefile combien de coeurs logique le system possede =>
`make -j32`
ou makefile var =? `export MAKEFLAGS=-j32`

verif tout est en place => `source ~/.bash_profile`

* Les SBU
la mesure Standard Build Unit (SBU)
Le temps nécessaire à la compilation en utilisant un seul cœur est ce que nous 
appellerons l'unité de compilation standard ou SBU.

II - Creation de la chaine d'outils croisee LFS et des outils temporaires 
- etape 1 - construction compilateur croisee et ses bibliotheques associees;
- etape 2 - utilisation de cette chaine d'outils croisee pour creer plusieurs utilitaires de maniere a les isoler de la distribution hote;
- etape 3 - entree dans environnement chroot (ameliore isolation de l'hote) et construction d'outils necessaire au system final.

Note techniques sur la chaine d'outils:
But=> produire une zne temp contenant un ensemble d'outils reconnus comme efficace et isolee du system hote.
compilation croisee presente un avantage => tout ce qui est compilee de maniere croisee ne peut pas dependre de l'env hote.

The build, machine where we build programs or host.
The host, machine/system where the build programs will run.
The target, use for compilateur, il s'agit de la machine pour laquelle le compilateur produit le code.

autoconf forme cpu-vendor-kernel-os 

revenir a cette addr =>
https://www.linuxfromscratch.org/lfs/view/stable/partintro/toolchaintechnotes.html

1 - Compilation d'une chaine d'outils croisee 
