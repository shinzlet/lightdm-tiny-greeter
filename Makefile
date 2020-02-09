PREFIX = /usr
CONFIG_PREFIX = /etc/lightdm
CC = gcc
RM = rm -f

CFLAGS = -std=c99 -pedantic -Wall -g # -O2
PKGS = `pkg-config --libs --cflags gtk+-3.0 liblightdm-gobject-1 gmodule-export-2.0`
LIBS = `pkg-config --libs gtk+-3.0 liblightdm-gobject-1 gmodule-export-2.0`

TARGET = lightdm-tiny-greeter

.PHONY: clean all install uninstall


all: $(TARGET)

$(TARGET): lightdm-tiny-greeter.o
	$(CC) -o $@ $^ $(LIBS)

lightdm-tiny-greeter.o: lightdm-tiny-greeter.c config.h
	$(CC) $(CFLAGS) -c $^ $(PKGS)

install:
	$(shell mkdir -p /usr/share/xgreeters)
	cp lightdm-tiny-greeter.desktop /usr/share/xgreeters/lightdm-tiny-greeter.desktop
	cp lightdm-tiny-greeter $(PREFIX)/bin/lightdm-tiny-greeter
	cp tiny-greeter.xml $(CONFIG_PREFIX)/tiny-greeter.xml
	cp tiny-greeter.css $(CONFIG_PREFIX)/tiny-greeter.css

uninstall:
	$(RM) /usr/share/xgreeters/lightdm-tiny-greeter.desktop
	$(RM) $(PREFIX)/bin/lightdm-tiny-greeter
	$(RM) $(CONFIG_PREFIX)/tiny-greeter.xml

clean:
	$(RM) *.o
	$(RM) $(TARGET)
