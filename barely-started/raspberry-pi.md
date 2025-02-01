# Raspberry Pi (and similar single-board computers)
A popular series of single board computers (SBCs) targeted at educational use; low cost and extendive documentation and comminity are major features.


## TODO list
* TODO: Links: Raspberry Pi foundation.
* TODO: Links: Raspbian site and ISOs.
* TODO: Links: ARMpbian site and ISOs.
* TODO: Links: Hardware details, comparison, datasheets.
* TODO: Links: Firmware update.
* TODO: Links: Adafruit.
* TODO: Links: Jeff Goerling.
* TODO: Links: tricks using /boot partition SSH, etc.
* TODO: Links: log2ram SDCard saver.
* TODO: Links: Disk imaging.
* TODO: Links: Backup, incl. rsycn.
* TODO: Links: RetroPi and other distros aimed at RsspberryPi.
* TODO: Links: Basic breadboard electronics.
* TODO: Links: Level shifters.
* TODO: Links: wlan enable guide, link to rationale for wlan region cautions.
* TODO: Links: Distro upgrade in-place for raspbian.
* TODO: Links: Vendors - Raspberry Pi , accessories esp. breakout cables.
* TODO: Links: General relevant guides and tutorals.
* TODO: Links: USB Gadget related (only some models).
* TODO: Links: PCIe related (only some models).
* TODO: Links: Network boot related - guides, docs, etc.
* TODO: Links: Fritzing circuit diagram drawing tool.
* TODO: Links: SD / MicroSD cards, related esoterica e.g. microsd extender cables.
* TODO: Links: Services, cronjobs, scheduling tasks to run without direct user invocation.
* TODO: Links: Mounting disks and filesystem.



## Quickstart
Enable SSH - If either of these files exist (regardless of contents) Raspberry Pi OS enables incoming SSH: `boot/ssh` `boot/ssh.txt`



## Files
Files in this repo also relevant to this topic.


## Links

### Official Raspberry Pi foundation documentation
From official sources.
* ["Getting started with your Raspberry Pi" (RPi docs)](https://www.raspberrypi.com/documentation/computers/getting-started.html#setting-up-your-raspberry-pi)
* ["raspi-config" (RPi docs)](https://www.raspberrypi.com/documentation/computers/configuration.html)
* ["boot folder contents" (RPi docs)](https://www.raspberrypi.com/documentation/computers/configuration.html#boot-folder-contents) [(adoc source code for "boot folder contents" page)](https://github.com/raspberrypi/documentation/blob/develop/documentation/asciidoc/computers/configuration/boot_folder.adoc)
* ["Raspberry Pi hardware" (RPi docs)](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html)
* ["Raspberry Pi" - (Github Organization / Collection of official git repositories) (Github)](https://github.com/raspberrypi)
* ["Kernel command line (cmdline.txt)" (RPi docs)](https://www.raspberrypi.com/documentation/computers/configuration.html#kernel-command-line-cmdline-txt)
* ["Remote access" (RPi docs)](https://www.raspberrypi.com/documentation/computers/remote-access.html)
* ["Screen share with VNC" (RPi docs)](https://www.raspberrypi.com/documentation/computers/remote-access.html#vnc)
* <https://github.com/orgs/raspberrypi/repositories?type=all>
* <https://github.com/raspberrypi/documentation> generates <https://raspberrypi.com/documentation>


### Pi SBC hardware
The Raspberry Pi board itself.
* ["Raspberry Pi hardware" (Raspberry Pi documentation)](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html)


### Pi optional addon hardware (SBC itself)
Things you can buy to plug into your Raspberry Pi board.


### Configuration
* ["raspi-config"  (RPi docs)](https://www.raspberrypi.com/documentation/computers/configuration.html)
* ["boot folder contents" (RPi docs)](https://github.com/raspberrypi/documentation/blob/develop/documentation/asciidoc/computers/configuration/boot_folder.adoc)


### OS Images
Operating systems you can put on your Raspberry Pi.

#### Raspberry Pi OS / Raspbian (Linux distro)
TODO

#### Armbian (Linux distro)
* <https://www.armbian.com/>
* <https://docs.armbian.com/>
* [Listing of Armbian supported Broadcom SOCs / devboards](https://www.armbian.com/download/?tx_soc=broadcom)
* <https://www.armbian.com/rpi4b/>
* <https://www.armbian.com/rpi5b/>
* [Armbian release images archive](https://imola.armbian.com/archive/)
* <https://thelinuxcode.com/installing-armbian-raspberry-pi/>



### Utils
* Disk image writer: [Rufus](https://rufus.ie/en/) and [Rufus source code on github](https://github.com/pbatard/rufus)


### Vendors
Places and people who can sell you stuff.

#### Adafruit
A US vendor who does good guides and has written and contributed to many software libraries. Good service and fast delivery, the slight price premium is generally worthwhile as you get your task done faster.
* ["Adafruit Store"](https://www.adafruit.com/)
* ["Adafruit Learn"](https://learn.adafruit.com/)
* [Adafruit blog / news](https://blog.adafruit.com/)

##### Adafruit(Guides)
Adafruit have released a lot of guides.
* ["Learn Raspberry Pi" (Adafruit Learn)](https://learn.adafruit.com/series/learn-raspberry-pi)
* <https://learn.adafruit.com/adafruits-raspberry-pi-lesson-2-first-time-configuration>
* <https://learn.adafruit.com/adafruits-raspberry-pi-lesson-3-network-setup?view=all>
* <https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable?view=all>
* <https://learn.adafruit.com/adafruits-raspberry-pi-lesson-6-using-ssh?view=all>
* <https://learn.adafruit.com/adafruit-raspberry-pi-lesson-7-remote-control-with-vnc?view=all>
* <https://learn.adafruit.com/raspberry-pi-computer-quick-start>
* <https://learn.adafruit.com/a-quick-linux-vm-on-windows-with-vagrant?view=all>
* <https://learn.adafruit.com/basic-shell-magic?view=all>
* <https://learn.adafruit.com/an-illustrated-guide-to-shell-magic-typing-less-and-doing-more?view=all>

##### Adafruit (Products)
* [Raspberry Pi product category (Adafruit Store)](https://www.adafruit.com/category/105)
* Example: ["Assembled Pi T-Cobbler Plus - GPIO Breakout - Pi A+, B+, Pi 2/3/4, Zero" (Adafruit Store)](https://www.adafruit.com/product/2028)
* [LEDs product category (Adafruit Store)](https://www.adafruit.com/category/37)
* [Tools product category (Adafruit Store)](https://www.adafruit.com/category/8)
* [Prototyping product category (Adafruit Store)](https://www.adafruit.com/category/82)
* Esoteric examples: ["SD Card Extender - 68cm (26 inch) long cable" (Adafruit Store)](https://www.adafruit.com/product/3687) and ["Micro SD Card Extender - 68cm (26 inch) long flex cable" (Adafruit Store)](https://www.adafruit.com/product/3688) and ["Micro SD Card PCB Extender" (Adafruit Store)](https://www.adafruit.com/product/4395)


#### DFRobot
DFRobot is a Chinese electronics module manufacturer who provide a decent amount of documentation on both their products and the components used in their products. Clones of their design are commonplace on amazon, aliexpress, ebay, and so on.

e.g. DFRobot make arduino-like microcontroller dev boards and compatable breakout boards, peripheral development boards 

e.g. The DFRobot wiki may help you obtain the documentation for the components you're working with, such as manuals and datasheets for LCDs, sensors, ICs, and so on.

* <https://learn.dfrobot.com>
* <https://wiki.dfrobot.com/>
* <https://wiki.dfrobot.com/What_is_mmWave_Millimeter_Wave>
* <https://wiki.dfrobot.com/Arduino_Common_Controller_Selection_Guide>
* <https://en.wikipedia.org/wiki/Zhiwei_Robotics_Corp>
* <https://en.wikipedia.org/wiki/LattePanda>


#### Others

### Unsorted links

* ["raspberrypi/usbboot" - "Raspberry Pi USB booting code" (Github)](https://github.com/raspberrypi/usbboot)
* <https://wiki.geekworm.com/Raspberry_Pi_4_Model_B>
* <https://wiki.geekworm.com/Raspberry_Pi>
* <https://wiki.geekworm.com/Browse_by_Category>
* Raspberry Pi and accessories <https://wiki.geekworm.com/Category:Raspberry_pi>
* <>
* <>
* <>










* ["TITLE" (SITE)](LINK)
* ["TITLE" (SITE)](LINK)
* ["TITLE" (SITE)](LINK)
* ["TITLE" (SITE)](LINK)



* ["REPONAME" - "DESC" (Github)](LINK)
* ["REPONAME" - "DESC" (Github)](LINK)
* ["REPONAME" - "DESC" (Github)](LINK)