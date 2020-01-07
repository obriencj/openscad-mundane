

use <../gears/bore.scad>;
use <../gears/gears.scad>;


with_eng_std_bore(5/8, 1, keyed=true) {
     herringbone_gear(1.5, 75, inch_to_mm(1), helix=-30);
};


// The end.
