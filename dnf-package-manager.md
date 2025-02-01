# DNF package manager
Fedora-like distros tend to use dnf or yum as their preinstalled package manager.


## Common operations
* TODO: Paragraph on this with links to docs


## Repositories
* TODO: Paragraph on this with links to docs
* TODO: EPEL
* TODO: RPMFusion


## Less frequent dnf commands
TODO: history, whatprovides, etc.
* TODO: Paragraph on this with links to docs


## Configuration
By default, config files: are located at:
`/etc/dnf/dnf.conf` and `/etc/yum.repos.d/*.repo`

To dump current configuration:
```bash
dnf config-manager --dump
```

Reference on config file:
```bash
man dnf.conf 5
```
* Online manpage: ["dnf.conf(5)"](https://www.man7.org/linux/man-pages/man5/dnf.conf.5.html)


## Distribution upgrades
Very likely to be distro-specific, so refer to docs specific to your distro.

* Fedora ["Upgrading to a new release"](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-new-release/)
* Fedora (Normal upgrade method): ["Upgrading Fedora Linux Using DNF System Plugin"](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/)
* Fedora (without `system-upgrade` plugin, esoteric): ["Upgrading Fedora using package manager"](https://fedoraproject.org/wiki/Upgrading_Fedora_using_package_manager)


## Autoupdates
* TODO: Paragraph on this with links to docs
* Automatically install updates: ["DNF Automatic"](https://dnf.readthedocs.io/en/latest/automatic.html)


## RPMs
Packaging system undelying DNF.
* TODO: RPM stuff.


## Links

### Cheatsheets
* [DNF Command Cheat Sheet](https://homelab-alpha.nl/linux/fedora/dnf-cheat-sheet/)

### DNF Tutorials
* ["Using the DNF software package manager" (Fedora docs)](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
* https://www.linuxfordevices.com/tutorials/dnf-command


### DNF documentation
#### DNF project documentation
* ["DNF Command Reference"](https://dnf.readthedocs.io/en/latest/command_ref.html)
* ["DNF Configuration Reference"](https://dnf.readthedocs.io/en/latest/conf_ref.html)
* Automatically install updates: ["DNF Automatic"](https://dnf.readthedocs.io/en/latest/automatic.html)
* ["DNF API Reference"](https://dnf.readthedocs.io/en/latest/api.html)
* ["DNF Users FAQ"](https://dnf.readthedocs.io/en/latest/user_faq.html)
* [""]()
* [""]()


#### Redhat DNF docs
RedHat docs are less reliable availability-wise but tends to be useful if you have access.
(Also they are often a bit prissy with a stick up their arse.)

* ["Red Hat Enterprise Linux / 9 / Managing software with the DNF tool / Appendix A. DNF commands list"](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_software_with_the_dnf_tool/assembly_yum-commands-list_managing-software-with-the-dnf-tool)
* Root level of Redhat package management docs: ["Red Hat Enterprise Linux / 9 / Managing software with the DNF tool"](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html/managing_software_with_the_dnf_tool/index)
* ["Managing software with the DNF tool / Chapter 3. Configuring DNF"](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_software_with_the_dnf_tool/assembly_configuring-yum_managing-software-with-the-dnf-tool)
* ["Managing software with the DNF tool" (Single-page)](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/managing_software_with_the_dnf_tool/index)
* ["Package listing for Red Hat Enterprise Linux 9" (Single-page)](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/package_manifest/index)


#### Yum documentation
Yum begat DNF.
* ["Yum Package Manager"](http://yum.baseurl.org/)
* ["yum faq"](http://yum.baseurl.org/wiki/Faq.html)
* ["Yum Guides"](http://yum.baseurl.org/wiki/Guides.html)
* ["yum-utils" listing](http://yum.baseurl.org/wiki/YumUtils.html)
* [""]()
* [""]()


### Repositories



### Unsorted links
* Widely used (DNF): [DNF source code repo on github](https://github.com/rpm-software-management/dnf)
* Bleeding edge (DNF5): [DNF5 source code repo on github](https://github.com/rpm-software-management/dnf5)
* Older (yum): [""]()
* [""]()


* [""]()
* [""]()
