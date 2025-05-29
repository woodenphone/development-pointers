# Linux partitining and creating filesystems
* WIP

## Creating partition table and partitions
The partition table is an index of logical partitions on the disk.

A partition is a predefined logical region of the disk that can be used to hold data cleanly and in isolation from the rest of the partitions and partition table. (You want to use at least one)

----------

Create partition table (Substitute values as appropritate):
```bash
sudo fdisk /dev/sdXX
```

Within fdisk:
```fdisk
## Remind self about commands
Command (m for help): m
## ... (Help omitted for readability)...

##   p   print the partition table
Command (m for help): p

Disk /dev/sdr: 18.19 TiB, 20000588955648 bytes, 39063650304 sectors
Disk model: TOSHIBA SERIALNUM_REMOVED
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: ID_REMOVED

##   g   create a new empty GPT partition table
Command (m for help): g
Created a new GPT disklabel (GUID: GUID_REMOVED).

##   n   add a new partition
Command (m for help): n
Partition number (1-128, default 1):
First sector (2048-39063650270, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-39063650270, default 39063648255):

Created a new partition 1 of type 'Linux filesystem' and of size 18.2 TiB.

##   w   write table to disk and exit
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

## (fdisk exits back to shell)
```

----------

Create partition:
```bash
sudo fdisk /dev/sdXX
```

Within fdisk:
```fdisk
## Remind self about commands
Command (m for help): m
## ... (Help omitted for readability)...

## View current partitions to ensure you are doing what you mean to
##   p   print the partition table
Command (m for help): p

##   n   add a new partition
Command (m for help): n
Partition number (1-128, default 1):
First sector (2048-39063650270, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-39063650270, default 39063648255):

## View current partitions to ensure you are doing what you mean to
##   p   print the partition table
Command (m for help): p

##   w   write table to disk and exit
Command (m for help): w
```
----------

Showing help within fdisk
```
Command (m for help): m

Help:

  DOS (MBR)
   a   toggle a bootable flag
   b   edit nested BSD disklabel
   c   toggle the dos compatibility flag

  Generic
   d   delete a partition
   F   list free unpartitioned space
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table
   i   print information about a partition
   e   resize a partition

  Misc
   m   print this menu
   u   change display/entry units
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty MBR (DOS) partition table
   s   create a new empty Sun partition table


Command (m for help):
```
----------


## Crating filesystem within a partition
Filesystems are the on-disk datastructure that handles the concept of files and folders.

List partitions (restricting to HDDs only via `--filter 'ROTA == 1'`)
```bash
$ date -Is; lsblk --paths --filter 'ROTA == 1' --output 'KNAME,SIZE,MODEL,SERIAL,FSTYPE,LABEL,UUID,PARTUUID'
```

----------

To create an NTFS filesystem:
```bash
sudo mkfs.ntfs --fast --with-uuid --label "SomeLabel" /dev/sdXpY
```
* https://wiki.archlinux.org/title/NTFS
* https://linux.die.net/man/8/mkfs.ntfs
* https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file#naming-conventions
* https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/label Label length: `An NTFS volume label can be up to 32 characters in length, including spaces. NTFS volume labels retain and display the case that was used when the label was created.`

----------

For BTRFS
```bash
sudo mkfs.btrfs -L "mylabel"  /dev/sdXpY
```
* https://wiki.archlinux.org/title/Btrfs
* https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html
* https://www.man7.org/linux/man-pages/man8/mkfs.btrfs.8.html
* https://btrfs.readthedocs.io/en/latest/ch-fs-limits.html
* https://www.man7.org/linux//man-pages/man8/btrfs-filesystem.8.html Label length: `the maximum allowable length shall be less than 256 chars and must not contain a newline. The trailing newline is stripped automatically`

----------

* TODO: Examples of other filesystems - NTFS, FAT32, ext2, ext3, ext4, XFS, ...

----------



## Editing fstab to make persistant mounts
Adding entries to `/etc/fstab` is the normal way to make filesystems get automatically mounted on startup.


Use `/dev/disk/by-partuuid/` or `/dev/disk/by-id` to refer to the partition to be mounted in order to ensure it only ever refers to that specific partition; rather than hoping kernel keeps the `/dev/sdXXpYY` reliably consistent and persistant 1-1 mapping (Proven to be a flawed assumption by practical experience).

UUID is exceptionally collission-resistant and so collissions for the UUID tend to only be from cloned partitions, which is a rare enough case to make it the most practical option.


Example fstab entry and comment explaining it.
```fstab
## Disk we use to store the local backup of the FLICKERSPOT radio project files (12TB ata-ST16000NM001G-L0K9J8_AS12DF34-part1) -(Ctrl-S 2025-04-21)
/dev/disk/by-partuuid/d373b068-4258-4723-af1c-b1f12552fb44 /media/nsa-collab-bkup/ auto nosuid,nodev,nofail,x-gvfs-show 0 0
```
* https://www.man7.org/linux/man-pages/man5/fstab.5.html


Editing fstab more safely: (For distros using systemd, e.g. Fedora, Alma, Rocky)
```bash
## Backup original config
sudo mkdir -vp /root/backup/
sudo cp -v /etc/fstab "/root/backup/etc-fstab.$(date +%Y-%m-%dT%H%M%S%z).bkup"
## Edit config:
sudo nano /etc/fstab
## Validate fstab.
date -Is; mount --fake ## (Obsolete method)
date -Is; sudo findmnt --verify ## (extra warnings if non-root)
## Reload config from file
date -Is; sudo systemctl daemon-reload 
date -Is; sudo mount
```

View stashed config files:
```bash
date -Is; sudo ls -lahQZF /root/backup/
```

----------


### Validating fstab

Old (unsupported?) way:
```bash
mount --fake
```
* https://www.man7.org/linux/man-pages/man8/mount.8.html

Newer way:
```bash
findmnt --verify
```
* https://www.man7.org/linux/man-pages/man8/findmnt.8.html

----------


## Sensible disk labels and names

Given the information from lsblk (example convenient copypasta provided):
```bash
$ date -Is; lsblk --paths --filter 'ROTA == 1' --output 'KNAME,SIZE,MODEL,SERIAL,FSTYPE,LABEL,UUID,PARTUUID'
/dev/sdr  18.2T TOSHIBA abcdef123456    1234567890ab
```
It's easy to come up with names that are decent for 
```
With the information from lsblk:
KNAME      SIZE MODEL                   SERIAL
/dev/sdr  18.2T TOSHIBA HDWG62AUZSVA    1234567890ab

Using the naming template of:
$nominalSize-$manufacturer-$serialNum

Gives:
20T-TOSHIBA-1234567890ab
```

## Misc snippets

Make temporary marker partition to indicate drive is tested:
```bash
sudo mkfs.ntfs --fast --with-uuid --label "testedok" /dev/sdXN
```


## Links
- https://phoenixnap.com/kb/linux-format-disk
* https://www.man7.org/linux/man-pages/man8/findmnt.8.html
* https://www.man7.org/linux/man-pages/man8/mount.8.html
* https://www.man7.org/linux/man-pages/man5/fstab.5.html






