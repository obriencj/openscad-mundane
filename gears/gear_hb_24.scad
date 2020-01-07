

use <bore.scad>;
use <gears.scad>;


with_eng_std_bore(7/8, mm_to_inches(20), keyed=true) {
     herringbone_gear(1.5, 24, 20, helix=30);
};


// The end.
