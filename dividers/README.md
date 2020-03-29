# Drawer Dividers

Given a drawer, break it into cubes!

Simply measure the drawer width, subtract a mm or so for slop, then
divide the number in half. Use the all_dividers module then to produce
an STL of single, double, triple, quad, halved, and quartered boxes
that will fit within the width of your drawer. Load the STL into your
slicer and break the render into multiple objects, then duplicate or
remove individual divider pieces for easy printing.

The default is based on boxes 100mm wide/deep, and 75mm tall. The
external dimensions are such that two single boxes take up the same
space as a double box, and two double boxes take up the same space as
a quad (which is also the same as four singles). This makes it easy to
create a layout in the drawer to suit the combinations of objects you
need to store. The halved and quartered boxes are the same width and
depth as a single, but only half as tall, and internally subdivided.

On my Prusa i3 MK3s, using 0.3mm layers and normal acceleration, a
print of two doubles or a double and two singles takes around 8 hours.

## Thingiverse

A customizable copy of this has been published to Thingiverse,
allowing anyone to easily create their own drawer-specific divider
sets.

* [View on Thingiverse](https://www.thingiverse.com/thing:4186746)
* [Customize on Thingiverse](https://www.thingiverse.com/apps/customizer/run?thing_id=4186746)
