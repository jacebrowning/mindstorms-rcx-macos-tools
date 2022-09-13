.PHONY: all
all: install

.PHONY: install
install: nqc/bin/nqc
nqc/bin/nqc:
	gitman install
	cd nqc && sudo make install

.PHONY: test
test: install
	nqc -Susb -TRCX2 -d -pgm 1 examples/music.nqc

.PHONY: clean
clean:
	sudo gitman uninstall
