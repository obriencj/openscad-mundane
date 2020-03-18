/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Small keyed spacer for use with the change gears.
*/


use <../common/units.scad>;
use <../gears/bore.scad>;

use <change_gears.scad>;


module gear_spacer() {
     with_eng_std_bore(default_bore(), default_thick(), keyed=true) {
	  rotate([0, 0, 30]) {
	       cylinder(default_thick_mm(), r=inch_to_mm(0.75), $fn=6);
	  };
     };
}


gear_spacer();


// The end.
