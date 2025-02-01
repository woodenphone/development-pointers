# SAS and general SCSI
* TODO: Links for following topics.
```
sg3_utils
sdparm
SMART spec.
smartmontools / smartctl
gmartcontrol
smartd
lsscsi
/dev/sdXpN
connectors and cabling
hba cards
scsi specification documents
scsi specification layout and points of interest
t10 working group site
firmware
linux kernel points of interest
windows docs on topic
EOL for cards
misbehaving EOL'd cards on new big rrives
ISCSI
SCSI log pages
lspci
scsi-aware cp mv etc commands
scsi commands
SCSI enclosure management methods
SCSI enclosures, switches, and backplanes
legacy sas - scanners, cdrom, printers, etc.
Modern projects RE legacy SAS
tape drives RE scsi bits
tapealert flags
whatever "over fabric" is about
```


## Links

#### sg3_utils - SCSI / SAS utils collection
https://man.archlinux.org/listing/extra/sg3_utils/
http://sg.danny.cz/sg/sg3_utils.html
https://github.com/doug-gilbert/sg3_utils
* "Arch manual pages" - https://man.archlinux.org/listing/extra/sg3_utils/


### General SCSI introduction
* "A brief introduction to SCSI" - https://www.devever.net/~hl/scsi
* "Serial Attached SCSI - Wikipedia" - https://en.wikipedia.org/wiki/Serial_Attached_SCSI


### SCSI Protocol documents
* "SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive" - https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/


#### Cabling and connectors
* "SCSI Cable Connector Guide | C2G" - https://www.cablestogo.com/learning/connector-guides/scsi


### Online resetting of SATA links
Resetting SATA / SAS devices without rebooting or physically unplugging - pure software.
* "Soft-resetting SATA devices in Linux · the.Zedt" - https://zedt.eu/tech/linux/soft-resetting-sata-devices-linux/
* "hard drive - How to reset and detect plug-in HDD/SSD via IDE or SATA without rebooting? - Ask Ubuntu" - https://askubuntu.com/questions/1054612/how-to-reset-and-detect-plug-in-hdd-ssd-via-ide-or-sata-without-rebooting
* "linux - SATA link reset - Unix &amp; Linux Stack Exchange" - https://unix.stackexchange.com/questions/253290/sata-link-reset


### SAS HBAs, raid cards, etc.
For giving your computer SAS ports; plug into your motherboard PCIe slots. Typically PCIe x8 card-edge connector.
* "MegaRAID SAS 9271-8i" - https://www.broadcom.com/products/storage/raid-controllers/megaraid-sas-9271-8i#downloads
* "MegaRAID SAS 9266-8i" - https://www.broadcom.com/products/storage/raid-controllers/megaraid-sas-9266-8i
* "SAS 9217-4i4e Host Bus Adapter" - https://ichabod-origin.aws.broadcom.com/products/storage/host-bus-adapters/sas-9217-4i4e
* "Convert LSI 9211-8i HBA card to IT mode" - https://nguvu.org/freenas/Convert-LSI-HBA-card-to-IT-mode/
* "Detailed newcomers&#39; guide to crossflashing LSI 9211/9300/9305/9311/9400/94xx HBA and variants | TrueNAS Community" - https://www.truenas.com/community/resources/detailed-newcomers-guide-to-crossflashing-lsi-9211-9300-9305-9311-9400-94xx-hba-and-variants.54/
* "Crossflashing Controllers - Unraid | Docs" - https://wiki.unraid.net/Crossflashing_Controllers
* "Hardware Compatibility - Unraid | Docs" - https://wiki.unraid.net/index.php/Hardware_Compatibility#PCI_SATA_Controllers
* "Updated: SAS HBA crossflashing or flashing to IT mode, Dell Perc H200 and H310 – techmattr" - https://techmattr.wordpress.com/2016/04/11/updated-sas-hba-crossflashing-or-flashing-to-it-mode-dell-perc-h200-and-h310/
* "How to flash a LSI SAS 3008 HBA (e.g. IBM M1215) to IT mode" - https://www.servethehome.com/flash-lsi-sas-3008-hba-e-g-ibm-m1215-mode/
* "mpi3mr - drivers/scsi/mpi3mr - Linux source code (v6.5.1) - Bootlin" - https://elixir.bootlin.com/linux/latest/source/drivers/scsi/mpi3mr
* "LSI command-line utility for SAS2 non-RAID controllers" - https://www.natecarlson.com/2010/08/23/lsi-command-line-utility-for-sas2-non-raid-controllers/
* "SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive" - https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/ECMA-111%2C%201st%20edition%2C%20December%201985/
* "Broadcom (LSI/Avago) HBA and RAID Controller Technical Discussion | ServeTheHome Forums" - https://forums.servethehome.com/index.php?threads/broadcom-lsi-avago-hba-and-raid-controller-technical-discussion.24119/
* "LSI RAID Controller and HBA Complete Listing Plus OEM Models | ServeTheHome Forums" - https://forums.servethehome.com/index.php?threads/lsi-raid-controller-and-hba-complete-listing-plus-oem-models.599/
* "marcan/lsirec: LSI SAS2008/SAS2108 low-level recovery tool for Linux" - https://github.com/marcan/lsirec


### T10 working group
Responsible for developing SCSI standards. Minutes of meetings and docs relating to spec development are available behind a basic self-signup email login. Unfortunately finished / complete versions are not available to the public without purchasing access from standards body.
* "T10 Working Drafts" - https://www.t10.org/drafts.htm#ADC_Family
* "T10 Working Drafts" - https://www.t10.org/drafts.htm


### Tape (Mostly Ultrium LTO tape)
* "How to start using an LTO6 tape backup drive with LTFS on Ubuntu Server? : sysadmin" - https://www.reddit.com/r/sysadmin/comments/3qfyhm/how_to_start_using_an_lto6_tape_backup_drive_with/
* "HPE StoreOpen and Linear Tape File System (LTFS) Software - Installation and Configuration" - https://support.hpe.com/hpsc/doc/public/display?docLocale=en_US&docId=emr_na-c04998409&withFrame
* "PowerVault LTO Tape Drive : Backup &amp; Recovery | Dell USA" - https://www.dell.com/en-us/work/shop/productdetailstxn/powervault-lto
* "How To Install and Use Docker on CentOS 7 | DigitalOcean" - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
* "mt(1): control magnetic tape drive operation - Linux man page" - https://linux.die.net/man/1/mt
* "How to Configure Persistent Names for Tape Devices in CentOS/RHEL – The Geek Diary" - https://www.thegeekdiary.com/how-to-configure-persistent-names-for-tape-devices-in-centos-rhel/
* "Linear Tape-Open - Wikipedia" - https://en.wikipedia.org/wiki/Linear_Tape-Open
* "LTO Tape - Bibliotheca Anonoma" - https://wiki.bibanon.org/LTO_Tape
* "Sal Guarisco: Install an LTO Drive | Larry Jordan" - https://larryjordan.com/articles/sal-guarisco-lto-drive/
* "LTO Barcode-Label-Generator" - https://tapelabel.de/
* "backup - mtx reverses the numbers given to tape drives by CentOS and scsi generic (sg) devices - Unix &amp; Linux Stack Exchange" - https://unix.stackexchange.com/questions/416664/mtx-reverses-the-numbers-given-to-tape-drives-by-centos-and-scsi-generic-sg-de
* "Debian LTO Drive Setup | Data Blog" - https://numberformatdata.wordpress.com/2014/02/01/debian-lto-2-drive-setup/
* "How to take and restore backup with an LTO tape drive in RedHat? - Unix &amp; Linux Stack Exchange" - https://unix.stackexchange.com/questions/27107/how-to-take-and-restore-backup-with-an-lto-tape-drive-in-redhat
* "What is the state of LTO optimizations for the Linux Kernel? : linux" - https://www.reddit.com/r/linux/comments/5vjkdc/what_is_the_state_of_lto_optimizations_for_the/
* "Linux Tape Backup With mt And tar Command Howto - nixCraft" - https://www.cyberciti.biz/faq/linux-tape-backup-with-mt-and-tar-command-howto/
* "Support for PowerVault LTO7 | Documentation | Dell US" - https://www.dell.com/support/home/us/en/04/product-support/product/powervault-lto7/docs
* "Archiving data to LTO Tape for long term storage and backups" - https://blog.networkprofile.org/archiving-data-to-lto-tape-for-long-term-storage-and-backups/
* "LTO Tape drive Linux experience..." - https://www.linuxquestions.org/questions/linux-hardware-18/lto-tape-drive-linux-experience-4175620090/
* "LTO Tape drive Linux experience..." - https://www.linuxquestions.org/questions/linux-hardware-18/lto-tape-drive-linux-experience-4175620090/
* "Rear View of the LTO Tape Drive" - https://www.ibm.com/support/knowledgecenter/HW2T8/con_7226sosg_07_7RearViewLTO.html
* "software recommendation - Could I use my webcam as a barcode reader? - Ask Ubuntu" - https://askubuntu.com/questions/195191/could-i-use-my-webcam-as-a-barcode-reader#195192
* "Backup to LTO Tape with progress, checksums and buffering Using cut, dd, du, tail, tar, tee" - https://www.commandlinefu.com/commands/view/13582/backup-to-lto-tape-with-progress-checksums-and-buffering
* "LTO Tape - Bibliotheca Anonoma" - https://wiki.bibanon.org/LTO_Tape
* "Vacuole’s Tech Blog: Tape Backups: Keeping the Tape Streaming" - https://dampfnudel.blogspot.com/2007/10/tape-backups.html
* Has more detailed density code than linux mt manuals - "mt(1) manual page" - https://nxmnpg.lemoda.net/1/mt
* "Tape Storage Command Cheatsheet" - https://gist.github.com/pojntfx/ff11fadb1f6b1c2fe12fc134a440a5da
* "cts comments on How to start using an LTO6 tape backup drive with LTFS on Ubuntu Server?" - https://www.reddit.com/r/sysadmin/comments/3qfyhm/how_to_start_using_an_lto6_tape_backup_drive_with/cyxpzo5/
* "SCSI Operation and Configuration" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/scsi-operation-and-configuration.html#GUID-3FDAE690-AB95-47E3-8A1F-896C07F29C2E
* "Command Descriptor Block (CDB) Structure" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/sect1test.html#GUID-2E7CE405-FC77-4A7A-8477-DF2312367DEA
* "Tape Storage - Documentation" - https://docs.oracle.com/en/storage/tape-storage/index.html
* "Oracle Linear Tape Open (LTO) Gen-6 Tape Drives Customer Documentation Library E38452-01" - https://docs.oracle.com/cd/E38452_01/index.html
* "Tape Storage Products Documentation Library" - https://docs.oracle.com/cd/F24623_01/#toggle20
* "Collection of stuff" - https://kelvin.nu/barcode
* "Win32_TapeDrive class - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-tapedrive
* "PrepareTape function (winbase.h) - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-preparetape
* "TAPE_GET_MEDIA_PARAMETERS (winnt.h) - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-tape_get_media_parameters
* "Self-help Solutions on Tape Storage Product Line J... - Hewlett Packard Enterprise Community" - https://community.hpe.com/t5/storeever-tape-storage/self-help-solutions-on-tape-storage-product-line-just-a-click/td-p/7088091
* "Drivers &amp; Software - HPE Support Center." - https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_0da0741bc19f497d8b35964bef
* "Ubuntu Manpage: mbuffer - measuring buffer" - http://manpages.ubuntu.com/manpages/precise/man1/mbuffer.1.html
* "moloney/tapeworm: Manage tape backups on Linux" - https://github.com/moloney/tapeworm
* "Ubuntu Manpage: mbuffer - measuring buffer" - http://manpages.ubuntu.com/manpages/precise/man1/mbuffer.1.html
* "Inquiry (12h)" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/inquiry-12h.html#GUID-48051F3D-35AC-4BBC-920A-06F3947C7F0C
* "Linear Tape Open (LTO) Tape Drives - Linear Tape Open (LTO) Tape Drives" - https://docs.oracle.com/en/storage/tape-storage/linear-tape-open/


#### Virtual tape
* "Mhvtl: a Tape-library Emulator Server - Bacula USA" - http://www.bacula.lat/mhvtl-a-tape-library-emulator-server/?lang=en
* "mhvtl - a linux virtual tape library - Fibrevillage" - http://fibrevillage.com/storage/122-mhvtl-a-linux-virtual-tape-library
* "DIY iSCSI Virtual Tape Library | ITHierarchy Inc" - https://www.ithierarchy.com/ITH/node/25
* "markh794/mhvtl: Linux based Virtual Tape Library" - https://github.com/markh794/mhvtl


#### LTFS
* "piste2750/rpm-ltfs: Spec files for LTFS" - https://github.com/piste2750/rpm-ltfs
* "Installing LTFS Tools on a Linux system - IBM Documentation" - https://www.ibm.com/docs/en/spectrum-archive-le?topic=system-installing-ltfs-tools-linux
* "LinearTapeFileSystem/ltfs: Reference implementation of the LTFS format Spec for stand alone tape drive" - https://github.com/LinearTapeFileSystem/ltfs
* "Installing LTFS Tools on a Linux system - IBM Documentation" - https://www.ibm.com/docs/en/spectrum-archive-le?topic=system-installing-ltfs-tools-linux
* "piste2750/rpm-ltfs: Spec files for LTFS" - https://github.com/piste2750/rpm-ltfs
* "Installing LTFS Tools on a Linux system - IBM Documentation" - https://www.ibm.com/docs/en/spectrum-archive-le?topic=system-installing-ltfs-tools-linux
* "Re: st driver doesn&#39;t seem to grok LTO partitioning" - https://yhbt.net/lore/all/20160125112130.1350643c@harpe.intellique.com/t/
* "Voina Blog (a tech warrior&#39;s blog) LTFS on Fedora Linux" - https://blog.voina.org/ltfs-on-fc22/
* "ltfs" - https://www.ibm.com/support/knowledgecenter/STQNYL_2.4.0/ltfs_managing_command_line_ltfs.html


#### LTO tape Media Auxillary Memory (MAM)
Ultrium / LTO tape cartridges have a RFID tag inside them holding various details (Both read-only and rewritable fields).
* "RFID chips [LTO-CM] in LTO Ultrium 5 tapes / Questions and Requests / Proxmark3 developers community" - http://www.proxmark.org/forum/viewtopic.php?id=2686
* "Re: [Networker] Reading LTO Cartridge Memory chip contents" - https://adsm.org/lists/html/Networker/2009-05/msg00358.html
* "scangeo/lto-cm: Read and write an LTO tape&#39;s cartridge memory chip" - https://github.com/scangeo/lto-cm
* "GitHub - AdamLaurie/RFIDIOt: python RFID / NFC library &amp; tools" - https://github.com/AdamLaurie/RFIDIOt
* "RFIDIOt.org - RFID IO tools" - http://rfidiot.org/
* "How to read LTO cartridge memory (was Re: Media Fault)" - https://adsm.org/lists/html/ADSM-L/2003-08/msg00779.html
* "c# - LTO Cartridge memory reader - Stack Overflow" - https://stackoverflow.com/questions/20093956/lto-cartridge-memory-reader
* "How to read LTO cartridge memory (was Re: Media Fault)" - https://adsm.org/lists/html/ADSM-L/2003-08/msg00779.html
* "RFID chips [LTO-CM] in LTO Ultrium 5 tapes / Questions and Requests / Proxmark3 developers community" - http://www.proxmark.org/forum/viewtopic.php?id=2686
* "Source code to access LTO cartridge memory (C/C#) - Stack Overflow" - https://stackoverflow.com/questions/20093956/source-code-to-access-lto-cartridge-memory-c-c
* "lto-cm/lto-cm.c at master · scangeo/lto-cm" - https://github.com/scangeo/lto-cm/blob/master/lto-cm.c
* "Adventures with single-drive backup to LTO tape using open source tools « Frederick&#39;s Timelog" - https://www.frederickding.com/posts/2021/08/adventures-with-single-drive-backup-to-lto-tape-using-open-source-tools-158864/
* "maminfo/mam-info.h at master · arogge/maminfo" - https://github.com/arogge/maminfo/blob/master/mam-info.h


#### Drive and library automation - tape robots
There's a whole SCSI specification for this, drive talks to library via RS-4xx differential serial link. Not much documentation or articles on this topic.
* "Drive ADI Interface" - https://docs.oracle.com/cd/E28385_01/en/E28378/html/STA102_Config_Library_SNMP.04.05.htm
* "SCSI Operation and Configuration" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/scsi-operation-and-configuration.html#GUID-3FDAE690-AB95-47E3-8A1F-896C07F29C2E
* "Command Descriptor Block (CDB) Structure" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/sect1test.html#GUID-2E7CE405-FC77-4A7A-8477-DF2312367DEA


#### LTO tape cryptography
It's a thing, lose the key and lose all the data.
* "debian - Linux LTO-4/5/6 Hardware AES Drive Encryption - Server Fault" - https://serverfault.com/questions/354069/linux-lto-4-5-6-hardware-aes-drive-encryption


#### Bareos / backula (backup util designed for tape)
* "Bareos Console — Bareos Documentation 18.2.6 documentation" - https://docs.bareos.org/TasksAndConcepts/BareosConsole.html
* "Installing bareos on Centos 7 | SvennD" - https://www.svennd.be/installing-bareos-on-centos-7/
* "barcus/bareos: Docker image of BareOS." - https://github.com/barcus/bareos
* "(3404) Bacula Configuration on CentOS7 - YouTube" - https://www.youtube.com/watch?v=Y7b8U6_eLDI&t=327s
* "Create a backup job on bareos | SvennD" - https://www.svennd.be/create-a-backup-job-on-bareos/
* "Bacula and Bareos - Hack Sphere Labs Wiki" - https://wiki.hackspherelabs.com/index.php?title=Bacula_and_Bareos
* "backup - Bacula &amp; Multiple Tape Devices, and so on - Server Fault" - https://serverfault.com/questions/396970/bacula-multiple-tape-devices-and-so-on?rq=1
* "Bacula Relabel Tape – Riaan&#39;s SysAdmin Blog" - https://blog.ls-al.com/bacula-relabel-tape/
* "Bareos - ArchWiki" - https://wiki.archlinux.org/index.php/Bareos


### Misc utils
* "man mbuffer (1): measuring buffer" - https://manpages.org/mbuffer


### General unsorted links
Need sorting into subsections.

















