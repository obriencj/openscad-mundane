#
# Your Makefile should look something like:
# -------- BEGIN foo/Makefile --------
# SOURCES = foo.scad
# include ../common/stl.mk
# --------- END foo/Makefile ---------
#
# You could also do:
# SOURCES = $(wildcard *.scad)
# instead, but you don't get tab completion that way.
#
default : all

TOPDIR = $(shell pwd)/..

include $(TOPDIR)/common/defaults.mk
include $(TOPDIR)/common/deps.mk

VPATH=$(TOPDIR)/common/

SRCDIR ?= $(shell pwd)
SOURCES ?= $(wildcard $(SRCDIR)/*.scad)
TARGETS ?= $(SOURCES:.scad=.stl)

all: $(TARGETS)

clean:
	$(RM) $(TARGETS)

$(TARGETS) :

%.openscad.stl: %.scad
	$(TIME) $(OPENSCAD) $< -o $@

%.stl : %.openscad.stl
	$(ADMESH) -f -d -v -n -b $@ $<

.PHONY : all clean default
.INTERMEDIATE : $(SOURCES:.scad=.openscad.stl)
