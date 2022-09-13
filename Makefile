.PHONY: all
all: install

.PHONY: install
install:
	gitman install
	cd nqc && sudo make install
