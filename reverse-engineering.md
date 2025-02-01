# Reverse engineering
Reverse engineering is basically figuring out how something works. Contrast engineering where you figure out how to make something work.

* TODO: Alphabetize sections.


## Hardware
* TODO: electronics theory links.
* TODO: Louis Rossman, EEVBlog, etc. similar component-level repair experts.
* TODO: connector identification.
* TODO: chip idendification - footprints, logos, pinouts, etc.
* TODO: Point out existance of 74-series generic logic and similar generic ICs.
* TODO: Pin-compatabile replacements for common chips are a thing e.g. I2C EEPROM.
* TODO: tools to obtain and how to get ones that arent shit.
* TODO: JTAG, UART, etc. test ports and pads.
* TODO: Voltage testing - "Thou shalt always check voltages."
* TODO: Oscilloscopes - use, obtatining, etc.
* TODO: Logic analyzers, esp. cheap generic ones.
* TODO: Vendor-specific debug protocols e.g. ARM
* TODO: In-circuit programming 
* TODO: Dumping memory chips
* TODO: Level shifter example.


## Software / firmware
* TODO: IDAPro.
* TODO: Ghidra.
* TODO: binwalk.
* TODO: Flashrom.
* TODO: Links to guides.
* TODO: Assembly language guides.
* TODO: architectures and what uses them.
* TODO: Windows binary layout (exe and dll).
* TODO: Linux binary layout (ELF).
* TODO: Explaination of compiler / linker toolchain
* TODO: Debuggers - e.g. GDB.
* TODO: Patching as a concept and in practice.


### SATA
* https://wiki.osdev.org/SATA
* https://www.intel.com/content/www/us/en/io/serial-ata/serial-ata-ahci-spec-rev1-3-1.html
* https://sata-io.org/downloads/8833
* https://sata-io.org/
* [Big bundle of SCSI/SAS/SATA documents](https://archive.org/details/SCSISpecificationDocumentsSCSIDocuments/)


### Software analysis
* https://github.com/horsicq/Detect-It-Easy


### Assorted windows debuggers etc
I heard these are what people used so copypata names in case they help.
* W32DASM ["W32DASM" items on archive.org](https://archive.org/search.php?query=subject%3A%22W32DASM%22)
* [OllyDbg](http://www.ollydbg.de/)
* [SoftICE (Wikipedia)](https://en.wikipedia.org/wiki/SoftICE)
* ["bugchecker"](https://bugchecker.com/) [vitoplantamura/BugChecker2002"" - "SoftICE-like debugger for Windows 2000 and XP. Archived." (Github)](https://github.com/vitoplantamura/BugChecker2002) ["vitoplantamura/BugChecker" - "SoftICE-like kernel debugger for Windows 11" (Github)](https://github.com/vitoplantamura/BugChecker)
* ["x64dbg/x64dbg" - "An open-source user mode debugger for Windows. Optimized for reverse engineering and malware analysis" (Github)](https://github.com/x64dbg/x64dbg)


### Assorted windows docs
* ["GetDriveTypeA function (fileapi.h)"](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getdrivetypea)



## Networking
* TODO: Ethereal / Wireshark - packet capture and analysis.
* TODO: USBProxy (beaglebone black) - MITM to snoop on USB communications.
* TODO: Links to beginner, intermediate, expert networking topics
* TODO: USB.
* TODO: 802.11 WiFi.
* TODO: 802.3 Ethernet.
* TODO: Serial - UARTs etc.
* TODO: Bluetooth and variants.
* TODO: Other radio protocols.


## Links
* TODO: Add lots of links


## Hardware
* ["Semiconductor Manufacturer Logos"](https://componentstash.com/reference/semiconductor-logos) and  ["Semiconductor Manufacturer Logos" (PDF version)](https://componentstash.com/assets/content/ic-logos/Semiconductor%20Manufacturer%20Logos%20and%20Marks%20-%20Component%20Stash.pdf)
* ["Transistor Lookup"](https://componentstash.com/reference/transistors)


## Relevant for reversing Firmware
* Binary ananysis tool: ["binwalk" (github repo)](https://github.com/ReFirmLabs/binwalk) [binwalk github repo's wiki](https://github.com/ReFirmLabs/binwalk/wiki#usage) ["Supported Signatures"](https://github.com/ReFirmLabs/binwalk/wiki/Supported-Signatures)
* Open source program for controlling the MiniPRO TL866xx series of chip programmers: ["minipro" website](https://davidgriffith.gitlab.io/minipro/) ["minipro" official git repo](https://gitlab.com/DavidGriffith/minipro)
* ["flashrom" website](https://www.flashrom.org/) ["Flashrom" source code repo (github)](https://github.com/flashrom/flashrom) ["Users documentation"](https://www.flashrom.org/user_docs/index.html) ["Supported hardware"](https://www.flashrom.org/supported_hw/index.html)
* CLI image viewer: ["feh – a fast and light image viewer "](https://feh.finalrewind.org/) ["Feh" (Archwiki)](https://wiki.archlinux.org/title/Feh) ["Feh" (Gentoo wiki)](https://wiki.gentoo.org/wiki/Feh) ["feh manpage"](https://man.archlinux.org/man/feh.1.en) [feh source code (github)](https://github.com/derf/feh)
* JTAGulator (JTAG testpoint enumeration and probing tool): ["JTAGulator"](https://grandideastudio.com/portfolio/security/jtagulator/) ["JTAGulator: Assisted discovery of on-chip debug interfaces" (github)](https://github.com/grandideastudio/jtagulator) [JTAGulator documentation wiki (github)](https://github.com/grandideastudio/jtagulator/wiki) ["JTAGulator by Grand Idea Studio" (no longer stocked)(Adafruit)](https://www.adafruit.com/product/1550) ["Building a JTAGulator"](https://www.seeleypentecost.com/posts/2020-08-21-building-a-jtagulator/)
* <https://www.man7.org/linux/man-pages/man1/objcopy.1.html> 
* <https://ftp.gnu.org/old-gnu/Manuals/binutils-2.12/html_node/binutils_5.html>

e.g. fix byte interleaving from endianness: [Source: comment on video "Verizon ONT Firmware Extraction", (retrieved 2025-01-15)](https://www.youtube.com/watch?v=BRnrYf-y4m8&lc=UgyaR2TL2Crwc2RXE9Z4AaABAg)
```bash
$ objcopy -Ibinary --reverse-bytes=2 fw.bin fw-reversed.bin
```


#### Binwalk (binary analysis tool)
Binary ananysis tool: 
* ["binwalk" (github repo)](https://github.com/ReFirmLabs/binwalk) 
* [binwalk github repo's wiki](https://github.com/ReFirmLabs/binwalk/wiki#usage)
* ["Supported Signatures"](https://github.com/ReFirmLabs/binwalk/wiki/Supported-Signatures)

Binwalk guides:
* ["Mastering Binwalk for Effective Firmware Analysis (with examples)"](https://commandmasters.com/commands/binwalk-common/)
* ["Short Tutorial: Firmware Analysis Tool Binwalk "](https://allabouttesting.org/short-tutorial-firmware-analysis-tool-binwalk/)
* ["A short introduction to binwalk "](https://gist.github.com/briankip/8f8747a2488af827e3b4)
* ["CTFLearn write-up: Forensics (Medium)"](https://deskel.github.io/posts/ctflearn/forensics-medium)
* <https://manpages.ubuntu.com/manpages/bionic/en/man1/binwalk.1.html>


#### Less-relevant but related
* ["Mirror of software for use with XGecu and Autoelectric's line of chip programmers (TL866A, TL866CS, TL866II Plus, T56, T48)"](https://github.com/Kreeblah/XGecu_Software)


## Bluetooth
The general consensus is bugs and vulnerabilites abound in Bluetooth stacks and implimentations, possible low-hanging fruit.

Multiple variants of Bluetooth optimized for different things.

Traditional Bluetooth is able to do high-bandwidth tasks such as streaming audio in realtime. 

BTLE is better for low-bandwidth tasks like providing a wireless serial port.


### Bluetooth reverse engineering articles and guides
Explainations of prior reverse engineering on Bluetooth:
* <https://reverse-engineering-ble-devices.readthedocs.io/en/latest/>
* <https://github.com/oliexdev/openScale/wiki/How-to-reverse-engineer-a-Bluetooth-4.x-scale>
* <https://github.com/brandonasuncion/Reverse-Engineering-Bluetooth-Protocols>
* <https://learn.adafruit.com/reverse-engineering-a-bluetooth-low-energy-light-bulb?view=all>


### Bluetooth development
Bluetooth introduction guides for novice developers:
* <https://learn.sparkfun.com/tutorials/bluetooth-basics/all>
* <https://learn.adafruit.com/category/bluefruit-slash-ble>


### Bluetooth protocol
Bluetooth protocol itself. Technical literature describing specifications and protocols involved.

Bluetooth protocol and specifications:
* <https://en.wikipedia.org/wiki/Bluetooth>
* <https://en.wikipedia.org/wiki/List_of_Bluetooth_protocols>
* <https://www.bluetooth.com/learn-about-bluetooth/tech-overview/>
* <https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/architecture,-mixing,-and-conventions/architecture.html>
* <https://www.engineersgarage.com/bluetooth-protocol-part-1-basics-and-working/>


Bluetooth Specification v5.4:
* ["Volume 0" - "Part C. Version History and Acknowledgments"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/consolidated-table-of-contents---compliance-requirements/version-history-and-acknowledgments.html)
* ["Volume 1. Architecture, Mixing, and Conventions"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/architecture,-mixing,-and-conventions.html)
* [Volume 2. BR/EDR Controller](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/br-edr-controller.html)
* ["Volume 3. Host"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/host.html)
* ["Volume 4. Host Controller Interface"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/host-controller-interface.html)
* ["Volume 6. Low Energy Controller"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/low-energy-controller.html)
* ["Volume 7. Wireless Coexistence Signaling and Interfaces"](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-54/out/en/wireless-coexistence-signaling-and-interfaces.html)


### Bluetooth related utilities
* TODO: BT Sniffing and packet capture.
* TODO: BT spoofing and packet replay.
* TODO: BT simple MITM and relay-style MITM.
* TODO: BT decoding and macket modification.
* TODO: BT fuzzing.


### Videos
* ["38c3 Demystifying Common Microcontroller Debug Protocols" (youtube)](https://www.youtube.com/watch?v=mBuBiaugmD8) and associated con talk listing entry: ["Demystifying Common Microcontroller Debug Protocols" (by Sean "xobs" Cross) (2024 / 38c3)](https://media.ccc.de/v/38c3-demystifying-common-microcontroller-debug-protocols)
* ["I Broke Sony's Terrible DRM" by Nathan Baggs](https://www.youtube.com/watch?v=vjkqI7dBDVg)


### Unsorted links
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* <https://ctflearn.com>


* ["" - ""  (Github)]()
* ["" - ""  (Github)]()