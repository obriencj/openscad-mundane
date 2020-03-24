
SOURCES = br-coin.scad br-keychain.scad break-room.scad

include ../common/stl.mk

VPATH = ../two-sided-snap-coin

br-coin.openscad.stl : two-sided-snap-coin.scad feather.svg
br-keychain.openscad.stl : br-coin.scad feather.svg
break-room.openscad.stl : feather.svg

# The end.
