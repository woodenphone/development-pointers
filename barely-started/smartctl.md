# Testing disks - smartctl



## Common tasks
Simple examples of common tesks.


Open manpage for `smartctl`:
```bash
$ man smartctl
```

Get brief usage information:
```bash
$ smartctl --help
```


### Identify disks
Not strictly smartctl itself, but very useful when using smartctl.

Identifying the linux device file associated with your disk.

List block devices (disks and partitions):
```bash
lsblk --paths --output 'KNAME,SIZE,MODEL,SERIAL,FSTYPE,LABEL,UUID,PARTUUID'
```

List mounted filesystems with their device file and their free space:
```bash
## Long-form args
df --human-readable --print-type

## Short-form args
df -hT
```


### View reports
Different examples of getting reports on a disk.

View very minimal health assessment (Anything but 'PASSED' means the drive is thinks it is going to die in the next day; If you get any other message then immediately stop using drive and back it up to another disk!):
```bash
sudo smartctl --health /dev/sda
```

Get some information about drive model for device:
```bash
sudo smartctl --info /dev/sda
```

Print vendor-specific attributes
```bash
sudo smartctl --attributes  /dev/sda
```

Get most information in for device:
```bash
sudo smartctl --all /dev/sda
```

Get very detailed information for device (What I use for normal sysadmin use):
```bash
sudo smartctl --xall /dev/sda
```

Get very detailed information in JSON format for device:
```bash
sudo smartctl --json=n --xall /dev/sda
```

Get report of most recently run SMART self-test for device:
```bash
sudo smartctl -c /dev/sda
```


### SMART self-tests
Simple examples of running disk self-tests.

Get report of most recently run SMART self-test for device:
```bash
sudo smartctl -c /dev/sda
```

Run short self-test on disk to detect obvious problems (about two minutes):
```bash
sudo smartctl --test=short /dev/sda
```

Run long self-test on disk to scan whole disk (Can take hours or days for larger HDDs):
```bash
sudo smartctl --test=long /dev/sda
```

These basic background selftests can be run while the disk is in use.



#### Captive SMART self-tests (Advanced topic)
Simple examples of running caaprtive-mode disk self-tests.

If you don't know why you want to run a captive test, you probably should just use a regular one instead.
Captive mode has extra nuances and caveats, but is situationally useful.

Captive mode is not just "Don't return until test results are in".

Captive tests require smartctl have exclusive use of disk. Do not permit the disk to be mounted until test stops.


Run short self-test on disk in captive mode:
```bash
sudo smartctl --test=short --captive /dev/sda
```

Run short self-test on disk in captive mode:
```bash
sudo smartctl --test=long --captive /dev/sda
```

### Outputting in machine-readable formats (e.g. JSON)

Get detailed information in JSON format for device, save to file:
```bash
sudo smartctl --json=n --xall /dev/sda
```



### Record reports to disk
Saving information to a file.

(Filenames are examples, replace them as appropriate.)

Get detailed information in human-readable format for device, save to file:
```bash
sudo smartctl --xall /dev/sda > "MyDiskName.smartctl--xall.txt"
```

Get detailed information in JSON format for device, save to file:
```bash
sudo smartctl --json=n --xall /dev/sda > "MyDiskName.smartctl--xall.json"
```



## Useful commands (copypasta)
Quickref for copy+paste into terminal.

These are meant to be useful for actual basic sysadmin use.

Get report of most recently run SMART self-test for device:
```bash
sudo smartctl -c /dev/sda
```


Get detailed info on disk, stash to a timestamped file, view result using 'less' as a pager for scrolling in the terminal ('q' exits less):
```bash
sudo smartctl --xall /dev/sda | tee -a "SMART.SomeDiskNameGoesHere.$(date +%Y-%m-%dT%H%M%S%z).smartctl-x.txt" | less
```


Get detailed information in JSON format for device, save to file (e.g. after running a test):
```bash
sudo smartctl --json=n --xall /dev/sda > "SomeDiskNameGoesHere.$(date +%Y-%m-%dT%H%M%S%z).smartctl-x.json"
```




## Complex bs
You might want to skip this section; WIP and likely too complex to be worth using and maintaining.

Attempt to autogenerate a shared filename prefix for output files.

e.g. given /dev/sda give back  `/dev/disk/by-id/ata-ST500LM021-C0FF3E_D3ADB33F` and a job name like `2025-05-04T13-31-20Z.ata-ST500LM021-C0FF3E_D3ADB33F` that can be used for output filenames like `2025-05-04T13-31-20Z.ata-ST500LM021-C0FF3E_D3ADB33F.smartctl-xall.json` and `2025-05-04T13-31-20Z.ata-ST500LM021-C0FF3E_D3ADB33F.tar.gz`

Making a nice name using `/dev/disk/by-id/foo -> /dev/bar` symlinks (Attempt):
```bash

find /dev/disk/by-id/ -type l -iname '!(*-part[:digit:]|nvme[:digit:]n[:digit:]p[:digit:])' -ilname 'sda' -print | grep sda

find /dev/disk/by-id/ -type l -regextype sed -iregex '/ata-.+-part[:digit:]+/;/nvme[:digit:]+n[:digit:]+p[:digit:]+/' ! -regex 'nvme-eui'   -ilname 'sda' -print

```

To avoid:
- `^[:alnum:]\{1,8\}-eui\.`
- `-part[:digit:]+$`
- `^dm-`


```
find /dev/disk/by-id/ -regextype grep -iregex '\(^dm-\|^[[:alnum:]]\{1,8\}-eui\.\|-part[[:digit:]]+$\)'
find /dev/disk/by-id/ -regextype grep -iregex '^dm-\'
```

#### p

```
[:digit:]
```
- https://www.gnu.org/software/findutils/manual/html_mono/find.html
- https://www.man7.org/linux/man-pages/man1/sed.1.html
- https://www.gnu.org/software/sed/manual/sed.html
- https://sed.js.org/



## Useful tricks




## Workarounds
Workarounds for certain issues, e.g. hardware that has different intentions than you.


### Workaround for external enclusure puttind drive to sleep
Some external USB enclosures put the disk to sleep after some period of inactivity. This interrupts any running SMART self-tests the disk may be running.

To avoid the disk sleeping, try ensuring it is being frequently accessed.


#### Keeping disk active (Shell example)
Commands to keep disk active:
```bash
## Switch to root user: (Required to access device file directly.)
sudo -i 
## Run a loop that will periodically read a small amount of data from the disk:
while true; do { sleep 10; offset=$((1 + $RANDOM % 100)); dd if="/dev/sda" of=/dev/null iflag=nocache ibs=1K skip="${offset?}" count=1 status=none; } done
## ( ctrl+c to exit loop )
## Exit from being root back to previous user
exit
```

- https://www.man7.org/linux/man-pages/man1/dd.1.html
- https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html


#### Keeping disk active (Script example)
Script to keep disk active:
```bash
#!/usr/bin/env bash
## keep-hdd-awake.sh
## Periodically read a small amount of data to keep disk awake.
## USAGE: ./$0 DEVICE
## ======================================== ##
echo "[${0##*/}] Starting, targeting device ${1@Q} (at $(date -Is))" >&2
echo "Script will loop forever until it is manually exited, press [control+c] to exit." >&2
while true; do
    sleep 10 ## Wait a little while between access attmpts.
    offset=$((1 + $RANDOM % 100)) ## Random number below 100
    dd if="${1?}" of=/dev/null iflag=nocache ibs=1K skip="${offset?}" count=1 status=none ## Read 1KiB data from the disk.
		## https://www.man7.org/linux/man-pages/man1/dd.1.html
		## https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html
		## nocache - Re-read from disk instead of using cache, while not clobbering anything.
		## $ sudo dd if="/dev/sda" of=/dev/null iflag=nocache ibs=1K skip="100" count=1 status=none
done
```

Using above script:
```bash
## Create file with script in it:
nano keep-hdd-awake.sh
## Set file executable:
chmod +x keep-hdd-awake.sh
## Run file as root:
sudo ./keep-hdd-awake.sh /dev/sda
## ( ctrl+c to exit script )
```

- The script will only stop when it is manually terminated. I suggest running it in its own (byobu / tmux / screen) window so you can leave it running while doing other work.


###

## Links
- https://www.man7.org/linux/man-pages/man1/dd.1.html
- https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html
- https://www.gnu.org/software/findutils/manual/html_mono/find.html
- https://www.man7.org/linux/man-pages/man1/sed.1.html
- https://www.gnu.org/software/sed/manual/sed.html
- https://sed.js.org/
