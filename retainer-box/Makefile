
SOURCES = magnetic-retainer-box.scad retainer-box.scad zoe-retainer.scad

include ../common/stl.mk

VPATH=../common:../hinges

CLAMSHELL_DEPS : clamshell.scad copies.scad
MAG_DEPS : magnetic-retainer-box.scad utils.scad hinges.scad $(CLAMSHELL_DEPS)

clamshell.openscad.stl : $(CLAMSHELL_DEPS)
magnetic-retainer-box.openscad.stl: $(MAG_DEPS)
retainer-box.openscad.stl : hinges.scad clasp2.scad $(CLAMSHELL_DEPS)
zoe-retainer.openscad.stl : $(MAG_DEPS)

# The end.
