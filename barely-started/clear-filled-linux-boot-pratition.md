# Dealing with a /boot partition that is too full


## systems using dnf package manager



### Solution
Give an ordered list of packages and their install times matching 'kernel':
```bash
sudo rpm --query --all --queryformat '%{name}-%{VERSION}-%{RELEASE}.%{arch} %{INSTALLTIME}\n' kernel | gawk -F ' ' -e '{$2=strftime("%Y-%m-%dT%H%M%S%z",  $2); print $0;}' | sort -h --key=2
```


Remove oldest kernel:
```bash
sudo dnf remove PACKAGE_NAME
```
(If anything other than 'kernel' is listed to be removed here, STOP IMMEDIATELY!)


Run system package update:
```bash
date -Is; sudo dnf update -y
```


Look at files in `/boot`:
```bash
sudo ls -lahF /boot
```

Find old files for an old kernel version in `/boot`:
```bash
sudo find /boot -name '*4.18.0-513*'
```

Delete thos files:
```bash
sudo find /boot -name '*4.18.0-513*' -delete
```





### Working-out
Show installed packages with `kernel` in the name
```bash
# Equivalent to: $ sudo rpm -qa grep 'kernel'
sudo rpm --query --all | grep kernel
```

Better way:
```bash
sudo rpm --query kernel
```

Show installed packages with name matching `kernel-[0-9]`:
```bash
# Equivalent to: $ sudo rpm -qa grep 'kernel-[0-9]' | sort -h
sudo rpm --query --all | grep 'kernel-[0-9]' | sort --human-numeric-sort
```

### Formatting output
Print a list of available query format tags:
```bash
rpm --querytags
```

To write the rpm query tags to a file:
```bash
rpm --querytags > rpm-querytags.txt
```
A copy of the rpm query tags is included in this repo at: </nonfree/linux-misc/rpm-querytags.txt>


Format the output (sort of like like printf, see dnf manpage):
```bash
# Equivalent to: $ sudo rpm -qa --qf QUERYFMT
# $ sudo rpm --query --all --queryformat QUERYFMT
```


To produce `package-name @installation_unixtime` e.g. `atop @1643309293`
```bash
sudo rpm --query --all --queryformat '%{NAME} @%{INSTALLTIME}\n'
```


```bash
sudo rpm --query --all --queryformat '%{NAME} @%{INSTALLTIME}\n'  | grep 'kernel-[0-9]' | sort --human-numeric-sort
```


#### Converting time format

Example: (Like `$ date +%Y-%m-%dT%H:%M:%S%z`)
```bash
sudo rpm --query --all --queryformat '%{NAME} %{INSTALLTIME}\n'  | awk -F ' ' -e '{print $1 " " strftime("%Y-%m-%dT%H%M%S%z",  $2) };'
```

```bash
$ sudo rpm --query --all --queryformat '%{NAME} %{INSTALLTIME}\n' | grep 'kernel' | awk -F ' ' -e '{print $1 " " strftime("%Y-%m-%dT%H:%M:%S%z"  $2) };'
```

Awk invocation seperately:
```bash
## Equivalent to:
## $ awk -F ' ' -e '{print $1 " " strftime("%Y-%m-%dT%H:%M:%S%z"  $2) };'
awk --field-separator ' ' --source'{print $1 " " strftime("%Y-%m-%dT%H%M%S%z",  $2) };'
```

Awk script seperately:
```awk
#!/usr/bin/env -S awk--field-separator ' ' --file 
## Convert second space-delimited field from unixtime to ISO-8601
{
    print $1 " " strftime("%Y-%m-%dT%H%M%S%z",  $2) 
};
```

---

Alternate awk script:
```awk
#!/usr/bin/env -S awk--field-separator ' ' --file 
## Convert second space-delimited field from unixtime to ISO-8601
## Replace $2 in-place so original input can be reproduced with the replacement.
{
    $2=strftime("%Y-%m-%dT%H%M%S%z",  $2);
    print $0;
};
```

Example alternate method:
```bash
$ sudo rpm --query --all --queryformat '%{NAME} %{INSTALLTIME}\n' | grep 'kernel' | awk -F ' ' -e '{$2=strftime("%Y-%m-%dT%H%M%S%z",  $2); print $0;}'
```

---
Just using awk:
```bash
$ sudo rpm --query --all --queryformat '%{NAME} %{INSTALLTIME}\n' | gawk -F ' ' -e '/kernel-/ {$2=strftime("%Y-%m-%dT%H%M%S%z",  $2); print $0;}'
```

Time format:
- `$ date +%Y-%m-%dT%H:%M:%S%z` in awk becomes ` strftime("Y-%m-%dT%H:%M:%S%z", $2)`
- `$ date +%Y-%m-%dT%H%M%S%z` in awk becomes ` strftime("Y-%m-%dT%H%M%S%", $2)`

- https://www.man7.org/linux/man-pages/man1/gawk.1.html
- https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
- https://wenhan.blog/post/awk-time-functions/


Joined together:
```bash
sudo rpm --query --all --queryformat '%{name}-%{VERSION}-%{RELEASE}.%{arch} %{INSTALLTIME}\n' kernel | gawk -F ' ' -e '/kernel/ {$2=strftime("%Y-%m-%dT%H%M%S%z",  $2); print $0;}' | sort -h --key=2
```

Better (awk doesn't need to execute regex when we already do search via dnf query):
```bash
sudo rpm --query --all --queryformat '%{name}-%{VERSION}-%{RELEASE}.%{arch} %{INSTALLTIME}\n' kernel | gawk -F ' ' -e '{$2=strftime("%Y-%m-%dT%H%M%S%z",  $2); print $0;}' | sort -h --key=2
```


Nicer system update invocation, records times:
```bash
date -Is; sudo time dnf update -y; date -Is;
```



### Links (dnf-related)
- https://www.man7.org/linux/man-pages/man8/rpm.8.html
- http://ftp.rpm.org/api/4.4.2.2/queryformat.html
- http://ftp.rpm.org/max-rpm/ch-queryformat-tags.html
- ["Maximum RPM" - "Taking the RPM Package Manager to the Limit"](http://ftp.rpm.org/max-rpm/index.html)


## Systems using apt package manager (PLACEHOLDER)
(PLACEHOLDER)
* TODO: Write if get around to it.



## Links
- https://unix.stackexchange.com/questions/546588/how-to-solve-at-least-34mb-more-space-needed-on-the-boot-filesystem
- https://www.cyberciti.biz/faq/installing-kernel-2-6-32-131-2-1-el6-x86_64-needs-8mb-on-boot-filesystem/
- https://www.baeldung.com/linux/free-up-boot-space
- https://linuxblog.io/fix-least-xmb-space-needed-boot-filesystem/

### awk / gawk
- https://www.man7.org/linux/man-pages/man1/gawk.1.html
- https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
- https://wenhan.blog/post/awk-time-functions/

