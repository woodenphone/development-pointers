# LTO Tape - LINKS
Links associated with: LTO / Ultrium, LTFS, and related topics.

## Files in this repo
(./examples/bash/decode-tape-log-page.sh)

## Manpages
* "man mbuffer (1): measuring buffer" - https://manpages.org/mbuffer
* "mt(1): control magnetic tape drive operation - Linux man page" - https://linux.die.net/man/1/mt
* Density codes: "mt(1) manual page" - https://nxmnpg.lemoda.net/1/mt
* TODO: sg3_utils manpages.
* TODO: sg3_utils manpages.
* TODO: lsscsi manpage.
* TODO: tapeinfo manpage.
* TODO: mt manpage.


## LTO tapes
* "Linear Tape-Open - Wikipedia" - https://en.wikipedia.org/wiki/Linear_Tape-Open
* "LTO Tape - Bibliotheca Anonoma" - https://wiki.bibanon.org/LTO_Tape
* Density codes: "mt(1) manual page" - https://nxmnpg.lemoda.net/1/mt
* TODO: sg3_utils manpages.


### LTO cartridge MAM (Media Acess Memory) RFID/NFC tag
* "Source code to access LTO cartridge memory (C/C#) - Stack Overflow" - https://stackoverflow.com/questions/20093956/source-code-to-access-lto-cartridge-memory-c-c
* "lto-cm/lto-cm.c at master · scangeo/lto-cm" - https://github.com/scangeo/lto-cm/blob/master/lto-cm.c
"How to read LTO cartridge memory (was Re: Media Fault)" - https://adsm.org/lists/html/ADSM-L/2003-08/msg00779.html
* "c# - LTO Cartridge memory reader - Stack Overflow" - https://stackoverflow.com/questions/20093956/lto-cartridge-memory-reader
* "RFID chips [LTO-CM] in LTO Ultrium 5 tapes / Questions and Requests / Proxmark3 developers community" - http://www.proxmark.org/forum/viewtopic.php?id=2686
* "scangeo/lto-cm: Read and write an LTO tape&#39;s cartridge memory chip" - https://github.com/scangeo/lto-cm
* "GitHub - AdamLaurie/RFIDIOt: python RFID / NFC library &amp; tools" - https://github.com/AdamLaurie/RFIDIOt
* "RFIDIOt.org - RFID IO tools" - http://rfidiot.org/
* "Re: [Networker] Reading LTO Cartridge Memory chip contents" - https://adsm.org/lists/html/Networker/2009-05/msg00358.html
* "maminfo/mam-info.h at master · arogge/maminfo" - https://github.com/arogge/maminfo/blob/master/mam-info.h
* TODO: sg3_utils manpages.


### Tape labels and barcodes - reading and writing
There's a spec for what a LTO label should look like, with color-coded digits.
* "LTO Barcode-Label-Generator" - https://tapelabel.de/
* "Collection of stuff" - https://kelvin.nu/barcode
* "software recommendation - Could I use my webcam as a barcode reader? - Ask Ubuntu" - https://askubuntu.com/questions/195191/could-i-use-my-webcam-as-a-barcode-reader#195192


## LTFS
* "Installing LTFS Tools on a Linux system - IBM Documentation" - https://www.ibm.com/docs/en/spectrum-archive-le?topic=system-installing-ltfs-tools-linux
* "LinearTapeFileSystem/ltfs: Reference implementation of the LTFS format Spec for stand alone tape drive" - https://github.com/LinearTapeFileSystem/ltfs
* "ltfs" - https://www.ibm.com/support/knowledgecenter/STQNYL_2.4.0/ltfs_managing_command_line_ltfs.html
* "piste2750/rpm-ltfs: Spec files for LTFS" - https://github.com/piste2750/rpm-ltfs
* ["HPE StoreOpen Software"](https://support.hpe.com/connect/s/softwaredetails?language=ja&collectionId=MTX-882b042a6fc04042&tab=releaseNotes)
* [LTFS on Fedora Linux](https://blog.voina.org/ltfs-on-fc22/)

### LTFS Dependancies
#### libicu (LTFS dependancy)
Required to build HPE LTFS "HPE StoreOpen Software" version 3.3.0.

Packages for version 50.1.2 are absent in Fedora 40 and later.

Consider using Alma 8 instead?

* ["ICU Documentation"](https://unicode-org.github.io/icu/)
* ["unicode-org/icu" - " The home of the ICU project source code." (Github)](https://github.com/unicode-org/icu/)
* <https://github.com/unicode-org/icu/releases/>
* <https://packages.fedoraproject.org/pkgs/libicu50/libicu50/epel-9.html>

"/icu4c-50_1_2-src.tgz"

* Dead link: https://icu.unicode.org/download/#/icu4c/51.2/icu4c-51_2-src.tgz
* <https://web.archive.org/web/20250115071304/https://icu.unicode.org/download/#/icu4c/50.1.2>
* <https://web.archive.org/web/20210911214858/https://icu.unicode.org/download/#/icu4c/51.2/**>
* <https://web.archive.org/web/*/http://download.icu-project.org/files/icu4c/50.1.2*>
* Versions of URL: <https://web.archive.org/web/20140501000000*/http://download.icu-project.org/files/icu4c/50.1.2/icu4c-50_1_2-src.tgz>
* Actual file: <https://web.archive.org/web/20140815102357/http://download.icu-project.org/files/icu4c/50.1.2/icu4c-50_1_2-src.tgz>

* PURELY INFORMATIONAL, tangential ["Unicode 16.0.0"](https://www.unicode.org/versions/Unicode16.0.0/)

* ["ICU-51.2 " - "Beyond Linux® From Scratch - Version 7.4"](https://www.linuxfromscratch.org/blfs/view/7.4/general/icu.html)


## Tape partitioning
Closely related to LTFS, LTO tape can be split into multiple logical partitions.
Be sure you know if you're counting up from 0 or from 1, so you don't have two partitions by mistake.
* "Re: st driver doesn&#39;t seem to grok LTO partitioning" - https://yhbt.net/lore/all/20160125112130.1350643c@harpe.intellique.com/t/
* TODO: Link mt manpage.
* TODO: Link sg3_utils manpages.
* TODO: Add examples of partitioning for LTFS and un-partitioning back to traditional non-LTFS layout.


## SAS utils useful for tape
* TODO: sg3_utils manpages.
* TODO: lsscsi manpage.
* TODO: tapeinfo manpage.
* TODO: mt manpage.


## Encryption
* "debian - Linux LTO-4/5/6 Hardware AES Drive Encryption - Server Fault" - https://serverfault.com/questions/354069/linux-lto-4-5-6-hardware-aes-drive-encryption


## HP / HPE (vendor)
HPE split off from HP.
* https://github.com/nix-community/hpe-ltfs/commit/f909474d71deb0e6a7abc71fd47c16a78b9c1eb0
* https://old.reddit.com/r/DataHoarder/comments/11orb52/how_to_download_hpe_storeopen_software_hpe/
* https://community.hpe.com/t5/storeever-tape-storage/hpe-storopen-ltfs-software-is-unavailable-for-download/m-p/7180110
* https://support.hpe.com/connect/s/product?language=en_US&tab=driversAndSoftware&kmpmoid=4249221
* https://support.hpe.com/connect/s/product?language=en_US&sp4ts.oid=1009214665&kmpmoid=4249221&tab=manuals#t=Documents
* https://support.hpe.com/hpesc/public/docDisplay?docLocale=en_US&docId=c05001914
* "Drivers &amp; Software - HPE Support Center." - https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_0da0741bc19f497d8b35964bef
* "HPE StoreOpen and Linear Tape File System (LTFS) Software - Installation and Configuration" - https://support.hpe.com/hpsc/doc/public/display?docLocale=en_US&docId=emr_na-c04998409&withFrame
* "Self-help Solutions on Tape Storage Product Line J... - Hewlett Packard Enterprise Community" - https://community.hpe.com/t5/storeever-tape-storage/self-help-solutions-on-tape-storage-product-line-just-a-click/td-p/7088091


## Oracle (vendor)
Despite their reputation, their docs are often the most extensive and easiest to get access to.
* "SCSI Operation and Configuration" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/scsi-operation-and-configuration.html#GUID-3FDAE690-AB95-47E3-8A1F-896C07F29C2E
* "Linear Tape Open (LTO) Tape Drives - Linear Tape Open (LTO) Tape Drives" - https://docs.oracle.com/en/storage/tape-storage/linear-tape-open/
* "Tape Storage - Documentation" - https://docs.oracle.com/en/storage/tape-storage/index.html
* "Oracle Linear Tape Open (LTO) Gen-6 Tape Drives Customer Documentation Library E38452-01" - https://docs.oracle.com/cd/E38452_01/index.html
* "Tape Storage Products Documentation Library" - https://docs.oracle.com/cd/F24623_01/#toggle20
* "Inquiry (12h)" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/inquiry-12h.html#GUID-48051F3D-35AC-4BBC-920A-06F3947C7F0C


## Dell (vendor)
* "PowerVault LTO Tape Drive : Backup &amp; Recovery | Dell USA" - https://www.dell.com/en-us/work/shop/productdetailstxn/powervault-lto
* "Support for PowerVault LTO7 | Documentation | Dell US" - https://www.dell.com/support/home/us/en/04/product-support/product/powervault-lto7/docs


## IBM (vendor)
* "Rear View of the LTO Tape Drive" - https://www.ibm.com/support/knowledgecenter/HW2T8/con_7226sosg_07_7RearViewLTO.html


## Windows tape-related
Windows has SCSI and tape support; but don't trust there to be a driver for your PCIe SAS HBA card in Windows11 though, Microsoft removed lots of device drivers going from 10 to 11.
* "Win32_TapeDrive class - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-tapedrive
* "PrepareTape function (winbase.h) - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-preparetape
* "TAPE_GET_MEDIA_PARAMETERS (winnt.h) - Win32 apps | Microsoft Learn" - https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-tape_get_media_parameter


## Specifications
* There's a lot of PDFs in this InternetArchive item; don't mistake it for just one file: []"SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive"](https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/)


### Specification bodies
* "T10 Working Drafts" - https://www.t10.org/drafts.htm#ADC_Family
* "T10 Working Drafts" - https://www.t10.org/drafts.htm
* TODO: INCIS
* TODO: ECMA


### Ultrium / LTO tape - (Specifications)
ECMA and such.
* TODO : Find and copy in links
* "SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive" - https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/ECMA-111%2C%201st%20edition%2C%20December%201985/


### LTFS - (Specifications)
* TODO: Links to LTFS specs.


### SAS / SCSI - (Specifications and details)
Interface for connecting tape drive to host. Most popular to my knowledge.
* "SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive" - https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/ECMA-111%2C%201st%20edition%2C%20December%201985/
* "SCSI Cable Connector Guide | C2G" - https://www.cablestogo.com/learning/connector-guides/scsi
* "Arch manual pages" - https://man.archlinux.org/listing/extra/sg3_utils/
* "A brief introduction to SCSI" - https://www.devever.net/~hl/scsi
* "Command Descriptor Block (CDB) Structure" - https://docs.oracle.com/en/storage/tape-storage/storagetek-sl150-modular-tape-library/slorm/sect1test.html#GUID-2E7CE405-FC77-4A7A-8477-DF2312367DEA
* "Serial Attached SCSI - Wikipedia" - https://en.wikipedia.org/wiki/Serial_Attached_SCSI


### Fiber Channel - (Specifications)
Interface for connecting tape drive to host. Declining in popularity.
* TODO: Links to FC specs.


### Library automation - (Specifications)
Protocols and specifications relating to tape libraries
* "SCSI Specification Documents: SCSI Documents : Free Download, Borrow, and Streaming : Internet Archive" - https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/ECMA-111%2C%201st%20edition%2C%20December%201985/


### Tape interchange between entities - (Specifications)
Tapes getting mailed to another datacenter.


## Backup software designed to work with tape
* "A Peek Under the Hood | Zmanda Documentation" - https://docs.zmanda.com/v/amanda-community/getting-started-with-amanda/a-peek-under-the-hood
* "Bareos Console — Bareos Documentation 18.2.6 documentation" - https://docs.bareos.org/TasksAndConcepts/BareosConsole.html
* "Installing bareos on Centos 7 | SvennD" - https://www.svennd.be/installing-bareos-on-centos-7/
* "barcus/bareos: Docker image of BareOS." - https://github.com/barcus/bareos
* "(3404) Bacula Configuration on CentOS7 - YouTube" - https://www.youtube.com/watch?v=Y7b8U6_eLDI&t=327s
* "Create a backup job on bareos | SvennD" - https://www.svennd.be/create-a-backup-job-on-bareos/
* "Bareos - ArchWiki" - https://wiki.archlinux.org/index.php/Bareos
* "moloney/tapeworm: Manage tape backups on Linux" - https://github.com/moloney/tapeworm
* "Bacula and Bareos - Hack Sphere Labs Wiki" - https://wiki.hackspherelabs.com/index.php?title=Bacula_and_Bareos
* "backup - Bacula &amp; Multiple Tape Devices, and so on - Server Fault" - https://serverfault.com/questions/396970/bacula-multiple-tape-devices-and-so-on?rq=1
* "Bacula Relabel Tape – Riaan&#39;s SysAdmin Blog" - https://blog.ls-al.com/bacula-relabel-tape/


## Tape related utilities
* Buggy? "~mbuffer/ - the home of the measuring buffer" - https://www.maier-komor.de/mbuffer.html
* "Ubuntu Manpage: mbuffer - measuring buffer" - http://manpages.ubuntu.com/manpages/precise/man1/mbuffer.1.html
* "tar(1) - Linux manual page" - https://man7.org/linux/man-pages/man1/tar.1.html
* "Ubuntu Manpage: tar — The GNU version of the tar archiving utility" - http://manpages.ubuntu.com/manpages/xenial/man1/tar.1.html


## Virtual tape software
* "markh794/mhvtl: Linux based Virtual Tape Library" - https://github.com/markh794/mhvtl
* "Mhvtl: a Tape-library Emulator Server - Bacula USA" - http://www.bacula.lat/mhvtl-a-tape-library-emulator-server/?lang=en
* "mhvtl - a linux virtual tape library - Fibrevillage" - http://fibrevillage.com/storage/122-mhvtl-a-linux-virtual-tape-library
* "DIY iSCSI Virtual Tape Library | ITHierarchy Inc" - https://www.ithierarchy.com/ITH/node/25


## Tape libraries / autoloaders / robots
Differential serial interface between tape drive and tape library.
* "Drive ADI Interface" - https://docs.oracle.com/cd/E28385_01/en/E28378/html/STA102_Config_Library_SNMP.04.05.htm


## Assorted guides
* "Backup to LTO Tape with progress, checksums and buffering Using cut, dd, du, tail, tar, tee" - https://www.commandlinefu.com/commands/view/13582/backup-to-lto-tape-with-progress-checksums-and-buffering
* "Vacuole’s Tech Blog: Tape Backups: Keeping the Tape Streaming" - https://dampfnudel.blogspot.com/2007/10/tape-backups.html
* "Adventures with single-drive backup to LTO tape using open source tools « Frederick&#39;s Timelog" - https://www.frederickding.com/posts/2021/08/adventures-with-single-drive-backup-to-lto-tape-using-open-source-tools-158864/
* "Tape Storage Command Cheatsheet" - https://gist.github.com/pojntfx/ff11fadb1f6b1c2fe12fc134a440a5da
* "Voina Blog (a tech warrior&#39;s blog) LTFS on Fedora Linux" - https://blog.voina.org/ltfs-on-fc22/
* "Linux Tape Backup With mt And tar Command Howto - nixCraft" - https://www.cyberciti.biz/faq/linux-tape-backup-with-mt-and-tar-command-howto/
* "cts comments on How to start using an LTO6 tape backup drive with LTFS on Ubuntu Server?" - https://www.reddit.com/r/sysadmin/comments/3qfyhm/how_to_start_using_an_lto6_tape_backup_drive_with/cyxpzo5/
* "Sal Guarisco: Install an LTO Drive | Larry Jordan" - https://larryjordan.com/articles/sal-guarisco-lto-drive/
* "How to start using an LTO6 tape backup drive with LTFS on Ubuntu Server? : sysadmin" - https://www.reddit.com/r/sysadmin/comments/3qfyhm/how_to_start_using_an_lto6_tape_backup_drive_with/
* "How to Configure Persistent Names for Tape Devices in CentOS/RHEL – The Geek Diary" - https://www.thegeekdiary.com/how-to-configure-persistent-names-for-tape-devices-in-centos-rhel/
* "Archiving data to LTO Tape for long term storage and backups" - https://blog.networkprofile.org/archiving-data-to-lto-tape-for-long-term-storage-and-backups/
* "LTO Tape drive Linux experience..." - https://www.linuxquestions.org/questions/linux-hardware-18/lto-tape-drive-linux-experience-4175620090/
* "Debian LTO Drive Setup | Data Blog" - https://numberformatdata.wordpress.com/2014/02/01/debian-lto-2-drive-setup/


## Trouble discussions
People having problems and seeking solutions, often finding them.
* "backup - mtx reverses the numbers given to tape drives by CentOS and scsi generic (sg) devices - Unix &amp; Linux Stack Exchange" - https://unix.stackexchange.com/questions/416664/mtx-reverses-the-numbers-given-to-tape-drives-by-centos-and-scsi-generic-sg-de
* "How to take and restore backup with an LTO tape drive in RedHat? - Unix &amp; Linux Stack Exchange" - https://unix.stackexchange.com/questions/27107/how-to-take-and-restore-backup-with-an-lto-tape-drive-in-redhat
* "What is the state of LTO optimizations for the Linux Kernel? : linux" - https://www.reddit.com/r/linux/comments/5vjkdc/what_is_the_state_of_lto_optimizations_for_the/


# Unsorted links
* ["HPE StoreOpen Software"](https://support.hpe.com/connect/s/softwaredetails?language=en_US&collectionId=MTX-882b042a6fc04042&tab=releaseNotes)


