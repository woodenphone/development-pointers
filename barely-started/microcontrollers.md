# Microcontrollers
e.g. Arduino

Setting up your dev environment, toolchains, dependancies; is in my experience the hardest part.

Learn basics of C as it's by far the most prevalent language for microcontroller programming.

Learn the basics of assembly language and low-level concepts such as memory addresses, registers, memory-mapping, memory management.

Learn enough commandline shell fundamentals to run your tools e.g. be able to understand the following: `simple-build.sh`
```bash
#!/usr/bin/env bash

## TODO: Typical basic compile command suitable for a normal microcontroller project.
gcc 
```

# Links

## Guides, tutorials, articles, examples
<https://github.com/m3y54m/start-avr>
<https://techexplorations.com/blog/arduino/arduino-programming-with-avr-c/>
<https://github.com/lfabbrini/avr-gcc-scons>
<https://github.com/h5b/arduino_uno_328p>
<https://www.instructables.com/AVR-Programming-with-Arduino-AVRdude-and-AVR-gcc/>
<https://github.com/JamesWilmot/arduino-avr-gcc-examples/>

## Manufacturers
### Atmel
ATTiny, AVR, ATMega.
Arduino started off using ATMega chips, though newer models of arduino board often use ARM-based ones instead.
Atmel was aquired by STMicro.

<https://www.microchip.com/en-us/about/corporate-overview/acquisitions/atmel>
<https://www.microchip.com/en-us/about/corporate-overview/acquisitions/atmel/atmega>
<https://www.microchip.com/en-us/about/corporate-overview/acquisitions/atmel/atxmega>
<https://www.microchip.com/en-us/about/corporate-overview/acquisitions/atmel/attiny>

<https://gcc.gnu.org/wiki/avr-gcc>
<https://www.avrfreaks.net/s/>
<https://www.nongnu.org/avr-libc/>
<http://savannah.nongnu.org/projects/avr-libc/>
<https://github.com/avrdudes/avr-libc/>
<https://avrdudes.github.io/avr-libc/>
<https://github.com/avrdudes/avr-libc/>
<https://sourceforge.net/projects/avarice/>
<http://savannah.nongnu.org/projects/simulavr/>
<http://savannah.nongnu.org/projects/avrdude>
<https://www.nongnu.org/avrdude/user-manual/avrdude.html>
<https://github.com/avrdudes/avr-libc/>
<https://www.nongnu.org/avr-libc/user-manual/index.html>

<https://gcc.gnu.org/wiki/avr-gcc>
<http://gcc.gnu.org/onlinedocs/gcc/C-Implementation.html>
<https://gcc.gnu.org/onlinedocs/gcc/Using-Assembly-Language-with-C.html>
<https://avrdudes.github.io/avr-libc/avr-libc-user-manual/inline_asm.html>



### STM32 series (ARM)
ARM-based.


### NRF series (Nordic) (ARM)
Lots of radio focus, e.g. wireless mouse and its usb dongle.


### ESP32 and ESP8266 series (Expressif)
Low-cost wifi / bluetooth.
Commonly sold as pre-certified module for integration to customer PCB. 
Originated targetting serial-wifi bridge application.
~1-4MiB SPI flash


## Architechtures
### 8051
Very popular minimal architechure.
check name



### RISCV



### Parallax Propeller
Interesting architechture, 6 cores.


## Development software
Software tools that run on your PC.
* Tool to run linux/unix programs on windows <http://www.mingw.org/> <http://www.cygwin.com/>
* <>
* <>


### Arduino development tools
* <http://arduino.cc/>
* <https://github.com/arduino>
* <https://github.com/arduino/toolchain-avr>
* <https://arduino.github.io/arduino-cli/1.1/sketch-build-process/>
* <>
* <>
* <>


### GCC
* <https://gcc.gnu.org/>
* <http://gcc.gnu.org/install/index.html>
* <http://gcc.gnu.org/install/binaries.html>

* <https://gcc.gnu.org/wiki/FAQ>
* <https://gcc.gnu.org/wiki/InstallingGCC>
* <https://gcc.gnu.org/onlinedocs/gcc/Using-Assembly-Language-with-C.html>
* <http://gcc.gnu.org/onlinedocs/gcc/C-Implementation.html>
* <https://gcc.gnu.org/wiki/plugins>
* <https://gcc.gnu.org/wiki/Libstdc++>
* <https://gcc.gnu.org/onlinedocs/libstdc++/manual/>
* <https://gcc.gnu.org/onlinedocs/libstdc++/faq.html>
* <>
* <>
* <>
* <>
* <>
* <>
* <>
* <>

## Code libraries aimed at microcontroller use
Software components that run on your microconroller.


## Unsorted links







