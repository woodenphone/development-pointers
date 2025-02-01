# Ansible
* TODO: Example inventory yml files hosts, host_vars, role_vars, inventory.


### Weird nomenclature
Ansible "controller" is what executes your playbook. (i.e. master)
Ansible "target" is what gets configured by your playbook (i.e. slave)


### Controller (master)
The thing that runs your playbooks.
* TODO: Methods of running ansible-controller master side: plain-linux; WSL; container; etc.

* [Getting started with Execution Environments](https://docs.ansible.com/ansible/latest/getting_started_ee/index.html)


#### Inventory
* TODO
`~/.ansible/hosts.yml`


#### Logging playbook runs
* TODO: Figure out how to configure for auto logging of all playbook runs to logfiles.
* TODO: Read these myself.
* https://docs.ansible.com/ansible/latest/reference_appendices/logging.html
* https://www.redhat.com/en/blog/ansible-logs-customize
* https://blog.devgenius.io/a-deep-dive-intologging-mechanisms-in-ansible-f78b6466e82c
* https://docs.ansible.com/ansible/latest/collections/community/general/log_plays_callback.html
* https://forum.ansible.com/t/logging-playbook-output-are-there-better-ways/7491
* https://docs.ansible.com/ansible/latest/plugins/callback.html
* https://forum.ansible.com/t/create-a-dedicate-log-for-every-runned-playbook/35673
* https://devops.stackexchange.com/questions/1277/how-do-i-log-task-output-to-a-file
* Stores in SQL DB (default sqlite): (https://github.com/ansible-community/ara) (https://ara.recordsansible.org/)
* https://docs.ansible.com/ansible/latest/collections/ansible/posix/profile_tasks_callback.html
* https://docs.ansible.com/ansible/latest/plugins/callback.html#callback-plugins
* https://docs.ansible.com/ansible/latest/collections/index_callback.html
* https://docs.ansible.com/ansible/latest/collections/community/general/log_plays_callback.html#ansible-collections-community-general-log-plays-callback

* https://docs.ansible.com/ansible/latest/reference_appendices/config.html#environment-variables
* https://docs.ansible.com/ansible/latest/collections/community/general/log_plays_callback.html#ansible-collections-community-general-log-plays-callback


Env var that sets ansible log file:
```bash
export ANSIBLE_LOG_PATH=/tmp/ansible_log.log
```

Maybe?:
```bash
mkdir -vp /ver/log/ansible-playbook/
export ANSIBLE_LOG_PATH=/tmp/ansible_log.log
```

Maybe?:
```conf
## ./ansible.cfg
[defaults]
display_args_to_stdout=True
LOG_VERBOSITY=2
DEFAULT_LOG_PATH=/tmp/ansible.log
log_path=./ansible_log.txt
stdout_callback=community.general.yaml
callbacks_enabled=ansible.posix.profile_tasks, ansible.posix.timer 
```

* May be easier to just make a wrapper script.



#### Packages (ansible-galaxy)
You can specify dependancies for your playbook and whatever using a `requirements.yml`file.
* ansible-galaxy
* ["Galaxy User Guide"](https://docs.ansible.com/ansible/latest/galaxy/user_guide.html)
* ["Ansible Galaxy site"](https://galaxy.ansible.com/)


## Development enviroment
The stuff you use when developing playbooks and so on.
* ["Ansible VS Code Extension by Red Hat"](https://marketplace.visualstudio.com/items?itemName=redhat.ansible)
* ["github.com/ansible/vscode-ansible"](https://github.com/ansible/vscode-ansible)


#### VScode config (Linux)
On linux I've found just having ansible installed is enough.


#### VScode config (Windows)
Configuring VSCode on Windows to have Ansible funtionality.
* ["Configuration" (VSCode extention readme)](https://github.com/ansible/vscode-ansible?tab=readme-ov-file#configuration)

TODO: Create config linking VSCode extention with WSL2.
WIP: WSL
```json
"ansible.ansible.path": "wsl /usr/bin/env ansible",
"ansible.python.interpreterPath": "wsl /usr/bin/env python3"
```

WIP: Container-based "Execution Environement"
```json
"ansible.executionEnvironment.enabled": "",
"ansible.executionEnvironment.image": ""
```

vscode://settings/ansible.ansible.path



## Development
Actually writing your playbooks and such.

* https://docs.ansible.com/ansible/latest/collections_guide/index.html#simplifying-module-names-with-the-collections-keyword


#### Developing for Windows targets
TIP: If you can do it in powershell, you can just execute that as a powershell script on the target.

* https://acozine.github.io/html/dev_guide/developing_modules_general_windows.html
* https://docs.ansible.com/ansible/5/dev_guide/developing_modules_general_windows.html
* https://docs.ansible.com/ansible/latest/os_guide/windows_usage.html
* https://acozine.github.io/html/dev_guide/developing_modules_general_windows.html
* https://docs.ansible.com/ansible/latest/os_guide/index.html
* https://github.com/ansible/ansible/tree/devel/lib/ansible/module_utils/powershell
* https://devblogs.microsoft.com/scripting/debugging-powershell-script-in-visual-studio-code-part-1/


* ["Windows Frequently Asked Questions"](https://docs.ansible.com/ansible/latest/os_guide/windows_faq.html)
* ["Windows Remote Management"](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html)
* ["Setting up a Windows Host"](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html)

* ["Desired State Configuration"](https://docs.ansible.com/ansible/latest/os_guide/windows_dsc.html)
* ["PowerShell Desired State Configuration (DSC) Overview" (learn.microsoft.com)](https://docs.microsoft.com/en-us/powershell/scripting/dsc/overview?view=powershell-7.2)
* "The Registry resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage registry keys and values on a target node." ["DSC Registry Resource" (learn.microsoft.com)](https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/registryresource)

Useful plugins/modules/roles for automating Windows targets:
* Ansible collection for community Windows plugins. ["Community.Windows" (Collection Index)](https://docs.ansible.com/ansible/latest/collections/community/windows/index.html)
* ["ansible.builtin.winrm connection – Run tasks over Microsoft’s WinRM"](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/winrm_connection.html)
* ["community.windows.win_scheduled_task module – Manage scheduled tasks"](https://docs.ansible.com/ansible/latest/collections/community/windows/win_scheduled_task_module.html)

* TODO: DOAS priv escalation and quirks
* TODO: Windows tricks - invisible user accounts for Ansible.
* TODO: Windows tricks - Autologin.
* TODO: Windows tricks - Control and delay/inhibit Windows Update.
* TODO: Windows - More on dism.exe and similar.
* TODO: Windows - 'net use' for SMB shares.
* TODO: Windows - Credential storage.


##### Running Powershell from Ansible
Multiple methods to execute Powershell code on a target. Different methods provide their own pros and cons.

* Runs a PowerShell script and outputs the data in a structured format. ["ansible.windows.win_powershell module – Run PowerShell scripts"](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_powershell_module.html)
* ["ansible.windows.win_shell module – Execute shell commands on target hosts"](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_shell_module.html)
* ["ansible.windows.win_command module – Executes a command on a remote Windows node"](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_command_module.html)

* ["community.windows.psexec module – Runs commands on a remote Windows host based on the PsExec model"](https://docs.ansible.com/ansible/latest/collections/community/windows/psexec_module.html)
* ["community.windows.win_psexec module – Runs commands (remotely) as another (privileged) user"](https://docs.ansible.com/ansible/latest/collections/community/windows/win_psexec_module.html)


#### Secure WinRM connections
* TODO: Find and copy in notes about Ansible WinRM security.
cert auth

Feel free to skip the detailed cryptography stuff as long as you are using certificate auth instead of basic auth (i.e. username+password).

Just copypaste something along the lines of this scrip to create your certificatet: <./examples/openssh certificates/mk-root-cert-example.sh>

Script to setup WinRM remoting on the target/client machine: <./examples/ansible-init/ConfigureRemotingForAnsible.ps1>

Script to add certificate to Windows user account to permit remote management via WinRM: <./examples/ansible-init/map-to-user.ps1>

Installing the certificate on the target is part of the initial setup, but you may elect instead to bootstrap the remote management by connecting via username+password to setup mandatory certificate authentication.


#### Detailed WinRM
* TODO: Move to seperate document


Creating certificate for WinRM authentication
----------
* See also: https://adamtheautomator.com/winrm-for-ansible/ for example of certificate auth for Ansible WinRM.

See script: <./examples/openssh certificates/mk-root-cert-example.sh>

Contents of `openssl.conf` for the user `ansibletestuser@localhost`
```conf
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req_client]
extendedKeyUsage = clientAuth
subjectAltName = otherName:1.3.6.1.4.1.311.20.2.3;UTF8:ansibletestuser@localhost
```

Creating the certificates:
```bash
export OPENSSL_CONF=openssl.conf
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -out cert.pem -outform PEM -keyout cert_key.pem -subj "/CN=ansibletestuser" -extensions v3_req_client
```


Advanced details about WinRM Certificate
----------
What goes into a certificate for WinRM:

* Describes cert format: ["[MS-WCCE]: Windows Client Certificate Enrollment Protocol"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/446a0fca-7f27-4436-965d-191635518466)
* Shows some things that use the cert format: ["1.4 Relationship to Other Protocols"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/08cb3552-573b-491c-b96a-d8f43996a009)
* Supports cert auth: ["[MS-DCOM]: Distributed Component Object Model (DCOM) Remote Protocol" (MSFT - [MS-DCOM])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dcom/4a893f3d-bd29-48cd-9f43-d9777a4415b0)
* Supports cert auth: ["[MS-RPCE]: Remote Procedure Call Protocol Extensions" " (MSFT - [MS-RPCE])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-rpce/290c38b1-92fe-4229-91e6-4fc376610c15)

* ["2.2.2.7 Certificate Request Attributes" (msft openspecs - [MS-WCCE])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/9503393d-7b41-42d0-adcf-2c4ac206406d)
* "OID = 1.3.6.1.4.1.311.20.2.3" ["2.2.2.7.5 szOID_NT_PRINCIPAL_NAME"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/ea9ef420-4cbf-44bc-b093-c4175139f90f)
* ["X.690 : Information technology - ASN.1 encoding rules: Specification of Basic Encoding Rules (BER), Canonical Encoding Rules (CER) and Distinguished Encoding Rules (DER)"](https://www.itu.int/rec/T-REC-X.690/en)
* ["{iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) 311 20 2 3}" (OID Repository)](https://oid-rep.orange-labs.fr/get/1.3.6.1.4.1.311.20.2.3)
* ["Object IDs associated with Microsoft cryptography" (OID Repository)](https://www.betaarchive.com/wiki/index.php?title=Microsoft_KB_Archive/287547)

* https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_certificates_in_idm/understanding-what-certificates-are-used-by-idm_managing-certificates-in-idm#certificates-internal-to-idm_understanding-what-certificates-are-used-by-idm


OpenSSL
----------
Used to create certificates for WinRM remote management.
* https://docs.openssl.org/master/man1/openssl/
* https://docs.openssl.org/master/man1/openssl-req/
* https://docs.openssl.org/master/man1/openssl-x509/
* https://docs.openssl.org/master/man5/config/
* https://docs.openssl.org/master/man5/x509v3_config/

* You can use `-config FILE` to tell openssl to use a specific config file ["Configuration Option" openssl(1) manpage (docs.openssl.org)](https://docs.openssl.org/master/man1/openssl/#configuration-option)


#### Developing for Linux targets
Linux targets tend to be the easiest to deal with, as the majority of available Collections / Modules / Roles / etc. support Linux.

Simple enough (in comparison to windows) to not have anywhere near as much need for explainations.

Linux-based Ansible targets can just use the normal SSH methods. `~/.authorized_keys` etc.


## Jinja2 templating
Jinja2 is the usual templating language when working with Ansible.

* This page is of little use: ["Templating (Jinja2)" (docs.ansible.com)](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html)
* Useful examples: ["Using filters to manipulate data" (docs.ansible.com)](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_filters.html)
* ansible.builtin.quote is a passthrough to Pythons shlex.quote ["ansible.builtin.quote filter – shell quoting" (docs.ansible.com - collections)](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/quote_filter.html#examples)
*  Documentation for underlying quoting mechanism used in `{{ foo | quote }}`: ["shlex.quote(s)" "shlex — Simple lexical analysis" (Python 3 docs)](https://docs.python.org/3/library/shlex.html#shlex.quote)

For Unix-like shells, do `{{ my_var | quote}}` to get the value into a form suitable for shell use. 

Not suitable for use on Windows! See warning in ["shlex.quote(s)" "shlex — Simple lexical analysis" (Python 3 docs)](https://docs.python.org/3/library/shlex.html#shlex.quote) for details why.

Alternative filter for Windows ["ansible.windows.quote filter – Quotes argument(s) for various Windows shells" (docs.ansible.com - collections)](https://docs.ansible.com/ansible/latest/collections/ansible/windows/quote_filter.html)

Values passing example:
```j2
#!/usr/bin/env bash
## foo.sh.j2
rclone --rc --rc-addr={{ rclone_rc_addr | quote }} \
    --config={{ rclone_config_filepath | quote }} \
    --bwlimit={{ rclone_bwlimit | quote }} \
    --checksum \
    copy \
    {{ filermeta_backup_tempfile | quote }} \
    {{ rclone_dest | quote }}
```


* Very useful Jinja2 reference: ["Template Designer Documentation" (Jinja docs)](https://jinja.palletsprojects.com/en/latest/templates/)


## Invoking ansible
* ["Using Ansible command line tools"](https://docs.ansible.com/ansible/latest/command_guide/index.html)

Verbosity level can be set like: `-v` `-vv`
Above verbosity of 2 the reported information becomes excessive for normal use.

Just perform a basic check of the syntax:
```bash
ansible-playbook -vv --syntax-check my-playbook.yml
```

Simulate running the playbook (It is not uncommon for tasks to report a failure in this mode)
```bash
ansible-playbook -vv --check my-playbook.yml
```
Some taks may depend on conditions not setup when running in `--check` mode. e.g. dirs will not be created, leading to tasks complaining about said dir being unavailable.

Running the playbook for real:
```bash
ansible-playbook -vv my-playbook.yml
```

* Example of what it might look like: (examples\ansible.practical-example.init-from-repo.md)


## Config
I've found that typically it's possible to write and use a yaml-formatted file instead of an ini-formatted file.

* ["Ansible Configuration Settings"](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
* [Config file precedence order](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file)

To print current config values:
```bash
ansible --version
```

```bash
ansible-playbook -v foo.yml
```

[Generating a sample ansible.cfg file]([https://docs.ansible.com/ansible/latest/reference_appendices/config.html#generating-a-sample-ansible-cfg-file]:
```bash
ansible-config init --disabled > ansible.cfg
```


### Config locations
- Ansible config file: `.ansible.cfg` `~/.ansible.cfg` `/etc/ansible.cfg`
- User ansible inventory file: `~/.ansible/inventory.yml` or `~/.ansible/inventory.ini`
- User ansible host_vars files: `~/.ansible/host_vars/SomeHost.yml` or  `~/.ansible/host_vars/SomeHost.ini`

* ["Ansible Configuration Settings"](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
* Setting value of patterns used to look for yaml variants of config files (default: `['.yml', '.yaml', '.json']`): ["YAML_FILENAME_EXTENSIONS" ("Ansible Configuration Settings")](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#yaml-filename-extensions)
* ["ansible.builtin.setup module – Gathers facts about remote hosts"](https://docs.ansible.com/ansible/9/collections/ansible/builtin/setup_module.html)



### Useful config vars
These configuration values look useful.
* File to which Ansible will log on the controller. When empty logging is disabled: ["DEFAULT_LOG_PATH" ("Ansible Configuration Settings")](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-log-path)


## Files


## Links
Sorted links.

* ["ansible/ansible" (github repo)](https://github.com/ansible/ansible)


### Ansible official site(s)
Links from official Ansible sites and repositories.
* ["Installation Guide"](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
* [Using Ansible command line tools](https://docs.ansible.com/ansible/latest/command_guide/index.html)

* ["ansible-playbook" Invocation](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
* ["ansible-galaxy" Invocation](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html)

* ["Special Variables"](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
* ["Using Variables"](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html)


#### Collections / Modules (Ansible official site)
* [Collection Index](https://docs.ansible.com/ansible/latest/collections/index.html)
* These are all modules and plugins contained in ansible-core. ["Ansible.Builtin" (Collection Index)](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html)
* Ansible collection for community Windows plugins. ["Community.Windows" (Collection Index)](https://docs.ansible.com/ansible/latest/collections/community/windows/index.html)
* A collection of PostgreSQL community modules for Ansible: ["Community.Postgresql" (Collection Index)](https://docs.ansible.com/ansible/latest/collections/community/postgresql/index.html)
* Podman container Ansible modules: ["Containers.Podman" (Collection Index)](https://docs.ansible.com/ansible/latest/collections/containers/podman/index.html#plugins-in-containers-podman)

* ["Indexes of all modules and plugins"](https://docs.ansible.com/ansible/latest/collections/all_plugins.html)
* ["Index of all Filter Plugins"](https://docs.ansible.com/ansible/latest/collections/index_filter.html)
* ["Index of all Lookup Plugins"](https://docs.ansible.com/ansible/latest/collections/index_lookup.html)
* ["Index of all Modules"](https://docs.ansible.com/ansible/latest/collections/index_module.html)
* ["Index of all Inventory Plugins"](https://docs.ansible.com/ansible/latest/collections/index_inventory.html)
* ["Index of all Connection Plugins"](https://docs.ansible.com/ansible/latest/collections/index_connection.html)
* ["ansible.builtin.winrm connection – Run tasks over Microsoft’s WinRM"](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/winrm_connection.html)

* Source for ansible-core modules: ["ansible/tree/devel/lib/ansible/modules" (github/ansible)](https://github.com/ansible/ansible/tree/devel/lib/ansible/modules)


#### Filters (Jinja2)
* Useful examples: ["Using filters to manipulate data" (docs.ansible.com)](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_filters.html)
* ["Index of all Filter Plugins"](https://docs.ansible.com/ansible/latest/collections/index_filter.html)
* Very useful Jinja2 reference: ["Template Designer Documentation" (Jinja docs)](https://jinja.palletsprojects.com/en/latest/templates/)



#### Windows (Ansible official site)
* ["Desired State Configuration"](https://docs.ansible.com/ansible/latest/os_guide/windows_dsc.html)
* ["Windows Frequently Asked Questions"](https://docs.ansible.com/ansible/latest/os_guide/windows_faq.html)
* ["Windows Remote Management"](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html)
* ["Setting up a Windows Host"](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html)
* ["Collection Index - Community.Windows"](https://docs.ansible.com/ansible/latest/collections/community/windows/index.html)
* Quoting strings for shell use: ["ansible.windows.quote filter – Quotes argument(s) for various Windows shells" (docs.ansible.com - collections)](https://docs.ansible.com/ansible/latest/collections/ansible/windows/quote_filter.html)


#### Routers and other network hardware (Ansible official site)
*TODO: paramiko
*TODO: IOS
*TODO: openwrt
*TODO: SNMP?


### Misc 3rd-party guides
#### 3rd-party Windows
* https://www.jonathanmedd.net/2020/03/running-powershell-7-commands-directly-on-ansible-localhost.html


#### Jeff Geerling (Guides and examples)
Makes lots of guides and FLOSS code for Ansible. Think Mavis Beacon but for Ansible. 
* ["Jeff Geerling's Ansible Content"](https://ansible.jeffgeerling.com)
* ["Ansible for DevOps examples."](https://github.com/geerlingguy/ansible-for-devops)
* ["Ansible for DevOps" (Book)](https://www.ansiblefordevops.com/)
* ["List of Jeff Geerling repositories"](https://github.com/geerlingguy?tab=repositories)


#### Examples by ctrls
* Repo for Ansible playbook writted to setup a laptop, includes scripting for Vagrant VM test environment: ["Ctrl-S/thinkpad-ansible.public" (Gitgud git repo)](https://gitgud.io/Ctrl-S/thinkpad-ansible.public)
* Repo for Ansible playbook for installing common linux stuff: ["Ctrl-S/ansible-generic-linux" (Gitgud git repo)](https://gitgud.io/Ctrl-S/ansible-generic-linux)
* Repo for Ansible playbook to setup a 4chan scraper: ["Ctrl-S/ansible-mitsuba" (Gitgud git repo)](https://gitgud.io/Ctrl-S/ansible-mitsuba)


### Additional information relating to Windows setup 
* [""]()
* [""]()


#### WinRM (Simple / user-friendly)
* https://adamtheautomator.com/winrm-for-ansible/


#### WinRM (Advanced details)
Certificates are the preferred authentication method for WinRM. Links about the certificates used.
* Describes cert format: ["[MS-WCCE]: Windows Client Certificate Enrollment Protocol"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/446a0fca-7f27-4436-965d-191635518466)
* Shows some things that use the cert format: ["1.4 Relationship to Other Protocols"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/08cb3552-573b-491c-b96a-d8f43996a009)
* Supports cert auth: ["[MS-DCOM]: Distributed Component Object Model (DCOM) Remote Protocol" (MSFT - [MS-DCOM])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dcom/4a893f3d-bd29-48cd-9f43-d9777a4415b0)
* Supports cert auth: ["[MS-RPCE]: Remote Procedure Call Protocol Extensions" " (MSFT - [MS-RPCE])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-rpce/290c38b1-92fe-4229-91e6-4fc376610c15)
* ["2.2.2.7 Certificate Request Attributes" (msft openspecs - [MS-WCCE])](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/9503393d-7b41-42d0-adcf-2c4ac206406d)
* "OID = 1.3.6.1.4.1.311.20.2.3" ["2.2.2.7.5 szOID_NT_PRINCIPAL_NAME"  (msft openspecs - [MS-WCCE]](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wcce/ea9ef420-4cbf-44bc-b093-c4175139f90f)
* ["X.690 : Information technology - ASN.1 encoding rules: Specification of Basic Encoding Rules (BER), Canonical Encoding Rules (CER) and Distinguished Encoding Rules (DER)"](https://www.itu.int/rec/T-REC-X.690/en)
* ["{iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) 311 20 2 3}" (OID Repository)](https://oid-rep.orange-labs.fr/get/1.3.6.1.4.1.311.20.2.3)
* ["Object IDs associated with Microsoft cryptography" (OID Repository)](https://www.betaarchive.com/wiki/index.php?title=Microsoft_KB_Archive/287547)
* ["Extracting Subject Alternative Name Other Name (1.3.6.1.4.1.311.20.2.3) from Microsoft authorization client certificates"](https://gist.github.com/spalladino/4665290)

### OpenSSL
Manpages for OpenSSL:
* https://docs.openssl.org/master/man1/openssl/
* https://docs.openssl.org/master/man1/openssl-req/
* https://docs.openssl.org/master/man1/openssl-x509/
* https://docs.openssl.org/master/man5/config/
* https://docs.openssl.org/master/man5/x509v3_config/


#### Routers and other network hardware (3rd-party)
*TODO: paramiko
*TODO: IOS?
*TODO: openwrt?
*TODO: SNMP?
* [""]()


### 3rd-party roles
* Create systemd units from yaml: https://github.com/O1ahmad/ansible-role-systemd
    https://github.com/O1ahmad/ansible-role-systemd/blob/master/templates/systemd.unit.j2
    https://github.com/O1ahmad/ansible-role-systemd/blob/master/tasks/common/config.yml
    https://github.com/O1ahmad/ansible-role-systemd/blob/master/tasks/common/launch.yml
    https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_service_module.html


## Linkdump
Misc barely-sorted links.
* https://developers.redhat.com/articles/2023/02/21/5-steps-install-microsoft-sql-rhel8-automation#
* https://phoenixnap.com/kb/install-ansible-on-windows
* https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_service_module.html





## DOCMETA
* ["TITLE" (docs.ansible.com)]()
* ["TITLE" (docs.ansible.com)]()
