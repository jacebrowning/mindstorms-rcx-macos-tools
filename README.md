# LEGO Mindstorms RCX on macOS

By now, the only (and best) solution is to use NQC.
NQC is a programming language with a syntax similar to C but it's Not Quite C.
For more information and documentation: http://bricxcc.sourceforge.net/nqc/

NQC is provided as a simple command line program which acts as a compiler and a tool to communicate with your RCX hardware to transmit firmware and programs.
Follow these simple steps and you'll be able to enjoy programming your old RCX brick on a modern Intel Mac.

The USB connection should just work. For the serial connection, the only requirement is a serial-to-USB adapter to connect the IR Tower to your computer. Find a cheap one based on the **PL2303** chip and install the kernel extension: http://www.xbsd.nl/2011/07/pl2303-serial-usb-on-osx-lion.html

## 1) Building NQC from sources

```sh
git clone https://github.com/jacebrowning/mindstorms-rcx-macos-tools.git
cd mindstorms-rcx-macos-tools
make install
```

If the build succeeds, the `nqc` executable will be installed globally.

## 2) Find the serial/USB port

Find the name of your serial port:

```sh
ls /dev/cu.*
```

This command will return a list of available devices. Look for something like `/dev/cu.PL2303-XXXX` and write it down. You will need this on all `nqc` commands with the flag `-S` (e.g. `-S/dev/cu.PL2303-XXXX`).

For the USB connection you will just use `usb` instead of `/dev/cu.PL2303-XXXX` (i.e. `-Susb`).

## 3) Uploading the official LEGO firmware

There are 3 LEGO firmwares in this repository:

**firm0309.lgo**: RCX firmware version 3.09 - Provided with RCX 1.0 & 1.5
**firm0328.lgo**: RCX firmware version 3.28 - Provided with RCX 2.0
**firm0332.lgo**: RCX firmware version 3.32 - Latest firmware from LEGO
**fast0612.lgo**: Experimental firmware that is [100x faster](https://pbrick.info/index.html-p=74.html)

We will use **firm0328.lgo** for now.

Send it to your brick (USB):

```sh
nqc -Susb -firmware firmwares/firm0328.lgo
```

or via serial:

```
nqc -S/dev/cu.PL2303-XXXX -firmware firmwares/firm0328.lgo
```

This will take a few minutes.

## 4) Send a test program to the RCX

I provide some example programs (from the NQC website) in the /examples folder

Upload the `music.nqc` program with this command (USB):

```sh
nqc -Susb -TRCX2 -d -pgm 1 examples/music.nqc
```

or via serial:

```sh
nqc -S/dev/cu.PL2303-XXXX -TRCX2 -d -pgm 1 examples/music.nqc
```

When the transfer is complete, you can test it on your brick by selecting program slot 1 and running it.

For more information on the NQC utility, please refer to the official manual:
http://bricxcc.sourceforge.net/nqc/doc/NQC_Manual.pdf

For the NQC syntax reference:
http://bricxcc.sourceforge.net/nqc/doc/NQC_Guide.pdf
