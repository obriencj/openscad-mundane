# Logan 820 Stuff

Items I've designed for use with my Logan 820 metal lathe.


## Change Gears

I purchased my Logan used and in somewhat rough shape. One of the
greatest oddities was the gearing arrangement leading to the QCGB. For
some bizarre reason a 21:72 ratio was in place, which translates to
just about nothing useful. I first printed a standard 24:48 ratio, but
then realized that with a 3D printer I can go much further, and set
about creating a herringbone set using an existing library.

However, this library rendered its gears very slowly, and when I
imported the resulting STL into slicer there were a huge number of
errors and separate manifolds flating around. So I set about writing
my own gear library (which is under [the gears directory](../gears) in
this repository), and using that to generate my change gear set.

The change_gears.scad (and rendered stl) have the following set of gears
* A 24-tooth gear taking input from the tumblers
* A 73-tooth idler gear
* A 48-tooth gear powering the QCGB

All are herringbone, and all have a 5/8" keyed bore. They have "speed
holes" which decreases the amount of material used, but also adds a
lot of strength through increased walls.

## Metric Transposing Gears

In the event that I want to try cutting metric, I've set up a stacked
pair of metric transposing gears. This is a 94:74 reduction (same as
the common 47:37 ratio). The doubling of size means that it fits
nicely as an idler when not being used as a metric transposer.

In normal imperial mode, simply use the 94-toothed section as an idler
between the 24-tooth and 48-tooth gears of the existing train.

To switch to metric transposing mode, place a spacer behind the
48-tooth gear such that it can mesh with the smaller 74-toothed gear
in the pair. This introduces the additional reduction necessary for
metric thread cutting.

Note that the center-line of the 74-toothed gear is offset slightly so
that there's a gap between the 48 and 94-toothed gear faces (ie. they
won't rub against one another).


## Spacer

Just a hex with the same thickness, bore, and keyway as the gears above.


## Slide Stop

Not really much of a stop, but useful for clamping a gauge to the ways
like a poor-bloke's DRO.
