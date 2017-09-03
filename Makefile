all:

PREFIX ?= /usr
BUILD_DIR := ./build
SOURCE_DIR := ./src
SUBDIRS := $(filter %/, $(wildcard $(SOURCE_DIR)/*/))
ZIPS := $(addsuffix .zip,$(shell basename -a $(SUBDIRS) 2>/dev/null))

all:

build: clean convert
	$(MAKE) dist

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(ZIPS)

convert:
	sh $(SOURCE_DIR)/_convert-to-png.sh

dist: $(ZIPS)

$(ZIPS): %.zip : | $(BUILD_DIR)/%
	zip -j $@ AUTHORS LICENSE $(BUILD_DIR)/$*/*

install:
	cp $(ZIPS) $(DESTDIR)$(PREFIX)/share/amule/skins

uninstall:
	rm -f $(foreach zip, $(ZIPS), $(DESTDIR)$(PREFIX)/share/amule/skins/$(zip))


.PHONY: all build clean convert dist install uninstall
