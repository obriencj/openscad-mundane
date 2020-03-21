
SOURCES = change_gears.scad metric_gears.scad slide_stop.scad spacer.scad

include ../common/stl.mk

VPATH = ../common:../gears

change_gears.openscad.stl : units.scad bore.scad gears.scad speed_holes.scad
metric_gears.openscad.stl : units.scad bore.scad gears.scad speed_holes.scad change_gears.scad
spacer.openscad.stl : units.scad bore.scad change_gears.scad

# The end.
