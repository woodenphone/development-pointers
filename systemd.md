# Systemd 
Service manager cum system manager daemon.
`systemctl` `journalctl` `foo.unit` `bar.service`


## Units
TODO: HAlf-decent description
* TODO: Links: freedesktop.org service,unit,timer,etc. directives


Unit files define services and when they should run plus more

`/etc/systemd/system/foo.service`

'root:root' 'rwx,rx,r' CONTEXT_HERE "foo.service"


Timers trigger Services to start.



### Unit files
Example permissions on a unit file
```bash
ls -lahQZF 

```

Process of placing or updating a unit file:
```bash
sudo cp -v "ctrls-torako-inst01.service" "/etc/systemd/system/ctrls-torako-inst01.service" # Copy service definition to service files location.

sudo chown -v root:root "/etc/systemd/system/ctrls-torako-inst01.service" # Assign ownership to root, as this is a system-wide configuration file

sudo chmod -v 'rwx,rx,r' "/etc/systemd/system/ctrls-torako-inst01.service" # Set file permissions.

sudo restorecon -v "/etc/systemd/system/ctrls-torako-inst01.service" # Set unit file SELinux security context.

sudo systemctl daemon-reload # Tell systemd to reload service configuration files.

sudo systemctl status "ctrls-torako-inst01.service"
```


## Service manager (systemctl)
* TODO: Examples of common use

### Basic examples of systemctl

Get status of service, timer, etc.:
```bash
#  systemctl status PATTERN 
sudo systemctl status my_service.service
```

Start a service:
```bash
sudo systemctl start my_service.service
```

Restart a service:
```bash
sudo systemctl restart my_service.service
```

Stop a service:
```bash
sudo systemctl stop my_service.service
```

Enable autorunning a service:
```bash
sudo systemctl enable my_service.service
```

Disable autorunning a service::
```bash
sudo systemctl disable my_service.service
```

List units:
```bash
sudo systemctl list-units
```

List units:
```bash
sudo systemctl list-unit-files
```

## System Journal
Primarily accessed via `journalctl`

Located on disk at: 
* TODO: FILEPATH(S).

* TODO: Examples of common use
```bash
## Long form arguments
sudo journalctl --boot --since="-15m" --unit=my_service --pager-end --follow

## Equivalent to previous
sudo journalctl --boot --since="15 minutes ago" --unit my_service.service --pager-end --follow

## Equivalent to previous; short form params.
## TODO: Short form command
## WIP: systemctl -b -S -15m -u my_service.service -e -w

## Equivalent to previous; short form params.
## WIP: systemctl -bew -S-15m -u my_service.service
```

Explain
```bash
sudo journalctl --boot --catalog --all --pager-end --grep 'some-pattern'
sudo journalctl -bxae -g 'some-pattern'
```


## Advice
Put your tob to be done in its own script that is just executed by the service. This clearly seperates the functional components of your task from the automated runner that starts it, and permits you to manually run whatever your code may be without having to care what systemd is doing.


## Links

### systemd documentation
(freedesktop.org)
* ["systemd.index — List all manpages from the systemd project"](https://www.freedesktop.org/software/systemd/man/latest/index.html)
* ["systemd.unit — Unit configuration"](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html)
* ["systemd.service — Service unit configuration"](https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html)
* ["systemd.timer — Timer unit configuration"](https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html#)
* [""]()
* [""]()
* [""]()
* ["file-hierarchy — File system hierarchy overview"](https://www.freedesktop.org/software/systemd/man/latest/file-hierarchy.html)
* ["journalctl — Print log entries from the systemd journal"](https://www.freedesktop.org/software/systemd/man/latest/journalctl.html)
* ["systemctl — Control the systemd system and service manager"](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html)
* [""]()
* [""]()

### Unsorted links
* [""]()
* [""]()

