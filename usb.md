# USB

## Basic introduction (USB)
* TODO: USB basic introduction for developers (VID+PID, transport modes, descriptors).

Master-Slave tree-shaped network bus, "Host" is bus master, "Device" are bus slave awaiting instructions from "Host"; "Hub" Provides multiple downstream ports from one upstream port.

USB Host is responsible for polling Devices for updates. 

Each USB device has VID (Vendoer ID) and PID (Product ID) and some number of device descriptors.

Minimum hardware to be detected as a USB device in Windows Device manager is a approximately one each of capacitor, reistor, transistor.

PROTIP: Spread bandwidth hog devices (e.g. HDDs) across multiple root ports on the Host to maximize throughput.

All devices on a USB Hub share the bandwidth and polling slots of the hub's upstream port.

It is relatively trivial for anyone who can construct a USB device to spoof USB VID, PID, and descriptors; and "USB Rubber Duckies" exist to teach caution to the unwary by injecting hilarious payloads to whatever host they are plugged into.

More sophisticated USB Ruber Ducks with onboard wifi exist, as do ones with full raspbarry-pi type computing hardware.

Since it's possible to just emulate a hub with multiple devices behind it, emulation of a multiple peripherals allows them to do more advanced fun tricks. (Similar to how one dongle can provide both keyboard and mouse.)


## USB Development
* TODO: More USB development links.
* ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (debian.org)](https://manpages.debian.org/bullseye/usbutils/lsusb.8.en.html) or ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (man7.org)](https://www.man7.org/linux/man-pages/man8/lsusb.8.html) or ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (man.archlinux.org)](https://man.archlinux.org/man/lsusb.8.en) and [List of manpages for "core/usbutils" (man.archlinux.org](https://man.archlinux.org/listing/core/usbutils/) also the upstream repo ["cgit logo 	index : kernel/git/gregkh/usbutils.git"](https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git/)
* ["usbhid-dump(8)" - "usbhid-dump - dump USB HID device report descriptors and streams" (Manpage) (man.archlinux.org)](https://man.archlinux.org/man/core/usbutils/usbhid-dump.8.en)
* ["Usbutils" (Gentoo Wiki)](https://wiki.gentoo.org/wiki/Usbutils)
* ["gregkh/usbutils" - "USB utilities for Linux, including lsusb"  (Github)](https://github.com/gregkh/usbutils)
* ["libusb/libusb" - "A cross-platform library to access USB devices "  (Github)](https://github.com/libusb/libusb) and [LibUSB website](https://libusb.info/)
* ["Linux USB Project"](http://www.linux-usb.org/)
* List of many USB VIDs (Vendor IDs)["All USB Vendors"](https://devicehunt.com/all-usb-vendors)
* [CircuitPython USB docs](https://docs.circuitpython.org/en/8.2.x/shared-bindings/usb/core/index.html)
* ["Simple Arduino-based USB VID & PID tester" (Adafruit)](https://learn.adafruit.com/simple-arduino-based-usb-vid-and-pid-tester?view=all)
* Book [](http://www.janaxelson.com/usbc.htm) ["USB complete : the developer's guide" (Internet Archive)](https://archive.org/details/usbcompletedevel0004edaxel)
* ["USB Complete Fourth Edition : The Developer's Guide" (Reviews) (GoodReads)](https://www.goodreads.com/book/show/6478724-usb-complete-fourth-edition)
Commercial USB Analyzer, you can DIY a cheaper alternative ["Beagle USB 12 - Low/Full Speed USB Protocol Analyzer" (Adafruit Store)](https://www.adafruit.com/product/708) ["Beagle Protocol Analyzer User Manual " (totalphase)](https://www.totalphase.com/support/articles/200472426-beagle-protocol-analyzer-user-manual/) ["Beagle USB 480 Protocol Analyzer" (Product page) (totalphase)](https://www.totalphase.com/products/beagle-usb480/)


## USB Specifications (USB)
Documents available from USB-IF (USB Implementers Forum):
* Many free to download specification documents: ["Document Library" (USB Implementers Forum)](https://www.usb.org/documents)
* ["USB 2.0 Specification" - "usb_20_20240927.zip" (USB Implementers Forum)](https://www.usb.org/document-library/usb-20-specification)
* Human Interface Device e.g. keyboard, mouse, gamepad ["HID Usage Tables 1.5" - "hut1_5.pdf" (USB Implementers Forum)](https://www.usb.org/document-library/hid-usage-tables-15)
* ["USB Power Delivery" - "202410 PD Delivery Package.zip" (USB Implementers Forum)](https://www.usb.org/document-library/usb-power-delivery)
* ["Mass Storage UFI Command Specification 1.0 " - "usbmass-ufi10.pdf" (USB Implementers Forum)](https://www.usb.org/document-library/mass-storage-ufi-command-specification-10)
* ["Mass Storage Bulk Only 1.0 " - "usbmassbulk_10.pdf" (USB Implementers Forum)](https://www.usb.org/document-library/mass-storage-bulk-only-10)
* ["USB MIDI Devices 1.0 " - "midi10.pdf" (USB Implementers Forum)](https://www.usb.org/document-library/usb-midi-devices-10)
* ["Power Device Class Document 1.0" - "pdcv10.pdf" (USB Implementers Forum)](https://www.usb.org/document-library/power-device-class-document-10)

Mirrors of documents on the Internet Archive:
* ["Universal Serial Bus Specification, Revision 2.0" (Internet Archive)](https://archive.org/details/USB-2.0)
* [" Universal Serial Bus 3.0 Specification, Revision 1.0 " (Internet Archive)](https://archive.org/details/universalserialbus3.0specificationrevision1.0)
* ["USB 2.0 revision + OTG standard" (Internet Archive)](https://archive.org/details/usb_20_202303/)
* ["USB 3.2 Revision 1.0" (Internet Archive)](https://archive.org/details/usb-3.2-revision-1.0)
* ['Results for search creator:"USB-IF' (Internet Archive)](https://archive.org/search?query=creator%3A%22USB-IF%22)


## lsusb (Show list of USB devides) (Linux)
Lsusb is a linux (probably other *nix OSes like BSD too) utility to provide the user info on attached USB devices.

Show quick-help:
```bash
lsusb --help
```

Basic view of detected USB devices:
```bash
sudo lsusb
```

Verbose information of detected USB devices:
```bash
sudo lsusb -v 
```

Specific USB device(s) by USB VID/PID:
```bash
## [-d vendor:[product]] - "Show only devices with the specified vendor and product ID numbers (in hexadecimal)"
## sudo lsusb -v -d vendor:[product]
sudo lsusb -v -d 1d6b # "1d6b:0002 Linux Foundation 2.0 root hub" (Chosen purely for demo reasons)
```

Specific USB device(s) by device file (e.g.`/dev/bus/usb/001/001`):
```bash
sudo lsusb -v -D /dev/bus/usb/001/001
```

* ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (debian.org)](https://manpages.debian.org/bullseye/usbutils/lsusb.8.en.html) or ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (man7.org)](https://www.man7.org/linux/man-pages/man8/lsusb.8.html) or ["lsusb(8)" - "lsusb - list USB devices" (Manpage) (man.archlinux.org)](https://man.archlinux.org/man/lsusb.8.en) and [List of manpages for "core/usbutils" (man.archlinux.org](https://man.archlinux.org/listing/core/usbutils/) also the upstream repo ["cgit logo 	index : kernel/git/gregkh/usbutils.git"](https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git/)
* ["usbhid-dump(8)" - "usbhid-dump - dump USB HID device report descriptors and streams" (Manpage) (man.archlinux.org)](https://man.archlinux.org/man/core/usbutils/usbhid-dump.8.en)
* ["Usbutils" (Gentoo Wiki)](https://wiki.gentoo.org/wiki/Usbutils)
* ["gregkh/usbutils" - "USB utilities for Linux, including lsusb"  (Github)](https://github.com/gregkh/usbutils)


## USB packet capture / analysis (USB)
* ["AristoChen/usb-proxy" - "A USB proxy based on raw-gadget and libusb" (Github)](https://github.com/AristoChen/usb-proxy) ["nesto-software/USBProxy" - "A USB proxy for rpi 4b, based on libUSB & gadgetFS - maintained by Nesto"](https://github.com/nesto-software/USBProxy)
* ["matlo/serialusb" "A cheap USB proxy for input devices." (Github)](https://github.com/matlo/serialusb)
* ["xairy/raw-gadget" - "USB Raw Gadget — a low-level interface for the Linux USB Gadget subsystem"  (Github)](https://github.com/xairy/raw-gadget)
* ["usb-tools/USBProxy-legacy" - "A proxy for USB devices, libUSB and gadgetFS - this project is unmaintained"  (Github)](https://github.com/usb-tools/USBProxy-legacy)
* ["greatscottgadgets/facedancer" - "Implement your own USB device in Python, supported by a hardware peripheral such as Cynthion or GreatFET"  (Github)](https://github.com/greatscottgadgets/facedancer)
* ["Emulating USB Devices with Python" - (Travis Goodspeed's Blog)](http://travisgoodspeed.blogspot.com/2012/07/emulating-usb-devices-with-python.html)
* ["Facedancer21"](https://goodfet.sourceforge.net/hardware/facedancer21/)
* Old and likely obsolete: ["woodenphone/usbproxy_for_idiots" (Github)](https://github.com/woodenphone/usbproxy_for_idiots)

