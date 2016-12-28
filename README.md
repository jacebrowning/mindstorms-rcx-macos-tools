#LEGO Mindstorms RCX on OS X

**After a lot of research on the web, I found it was a pain in the ass to communicate with the RCX on a MacBook Pro running OS X Mavericks.**

By now, the only (and best) solution is to use NQC.

NQC is a programming language with a syntax similar to C but it's Not Quite C.

For more information and documentation: http://bricxcc.sourceforge.net/nqc/

NQC is provided as a simple command line program which acts as a compiler and a tool to communicate with your RCX hardware to transmit firmware and programs.

Follow these simple steps and you'll be able to enjoy programming your old RCX brick on a modern Intel Mac.

USB Connection just works. For Serial Connection _The only requirement is a Serial to USB adapter_ to connect the IR Tower to your computer. Find a cheap one based on the **PL2303** chip and install the kernel extension: http://www.xbsd.nl/2011/07/pl2303-serial-usb-on-osx-lion.html

##1) Building NQC from sources

For the lazy ones, I also provide a compiled version inside the /binaries folder.  
(If you want to use it, copy the nqc executable inside your /usr/local/bin directory and go directly to step 2)

```sh
git clone https://github.com/Glitchbone/mindstorms-rcx-osx-tools.git
cd mindstorms-rcx-osx-tools
git submodule init
git submodule update
cd nqc
sudo make install
```

If the build succeeds, the nqc executable will be installed globally.

##2) Find the serial/usb port

Find the name of your serial port:
```sh
ls /dev/cu.*
```
This command will return a list of available devices. Look for something like `/dev/cu.PL2303-XXXX` and write it down. You will need this on all nqc command with the flag `-S` (ex: `-S/dev/cu.PL2303-XXXX`)

For USB connection you should use `usb` instead of `/dev/cu.PL2303-XXXX`. ie: `-Susb`

##3) Uploading the official LEGO firmware

I provide 3 LEGO firmware in this repository:

**firm0309.lgo**: RCX firmware version 3.09 - Provided with RCX 1.0 & 1.5  
**firm0328.lgo**: RCX firmware version 3.28 - Provided with RCX 2.0  
**firm0332.lgo**: RCX firmware version 3.32 - Latest firmware (Not sure if this one is compatible with NQC)

We will use firm0328.lgo for now.

Send it to your brick (Serial):
```sh
nqc -S/dev/cu.PL2303-XXXX -firmware firmwares/firm0328.lgo
```

Send it to your brick (USB):
```sh
nqc -Susb -firmware firmwares/firm0328.lgo
```

This will take a few minutes.

##4) Send a test program to the RCX

I provide some example programs (from the NQC website) in the /examples folder

Upload the music.nqc program with this command:
```sh
nqc -S/dev/cu.PL2303-XXXX -TRCX2 -d -pgm 1 examples/music.nqc
```
When the transfer is complete, you can test it on your brick by selecting program slot 1 and running it

For more informations on the NQC utility, please refer to the official manual:  
http://bricxcc.sourceforge.net/nqc/doc/NQC_Manual.pdf

For the NQC syntax reference:  
http://bricxcc.sourceforge.net/nqc/doc/NQC_Guide.pdf
