all:

BUILD_DIR := ./build
SUBDIRS := $(wildcard $(BUILD_DIR)/*/)
ZIPS := $(addsuffix .zip,$(shell basename -a $(SUBDIRS) 2>/dev/null))

all:

build: clean convert
	$(MAKE) dist

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(ZIPS)

convert:
	sh src/_convert-to-png.sh

dist: $(ZIPS)

$(ZIPS): %.zip : | $(BUILD_DIR)/%
	zip -j $@ $(BUILD_DIR)/$*/*

install:

uninstall:


.PHONY: all build clean convert dist install uninstall
