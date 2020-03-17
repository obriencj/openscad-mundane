/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  This is a stacked pair of gears, meant to replace the idler.  Can be
  used as an idler, and has no impact on the gear train.  But can also
  be used as a transposing gear by adjusting the QTGB to mate with the
  smaller of the stack.
*/


use <../common/units.scad>;
use <../gears/bore.scad>;
use <../gears/gears.scad>;
use <../gears/speed_holes.scad>;

use <change_gears.scad>;


module herringbone_metric_transposing() {

     // because a 47 toothed gear is too small to act as an idler, we
     // double it up. And to keep the ratio correct we do the same to
     // both.
     tooth_scale = 2;
     teefs_a = 47 * tooth_scale;
     teefs_b = 37 * tooth_scale;

     bore = default_bore();
     thick = default_thick();
     modul = default_modul();
     helix = default_helix(true);

     thick_mm = inch_to_mm(thick);
     bore_mm = inch_to_mm(bore);

     // determine the space for the speed holes, based on the smaller
     // gear in the stack.
     eng_keysize = eng_std_keysize(bore);
     inner_r = (bore_mm + inch_to_mm(eng_keysize)) / 2;
     outer_r = root_radius(modul, teefs_b) - 2;

     standoff = 0.5;
     othick_mm = thick_mm + (standoff * 2);

     with_speed_holes(inner_r + 2, outer_r - 2, (thick_mm * 2) + standoff) {
	  with_eng_std_bore(default_bore(), 1 + thick * 2, keyed=true) {

	       // the lower, larger gear
	       herringbone_gear(modul, teefs_a,
				thick_mm, helix=helix);

	       // the upper, smaller gear. This one is slightly fatter
	       // on one side, to give a half milimeter of clearance
	       translate([0, 0, thick_mm - 0.001]) {
		    intersection() {
			 herringbone_gear(modul, teefs_b,
					  othick_mm, helix=helix);
			 cylinder(r=outer_r * 2, thick_mm + standoff);
		    };
	       };
	  };
     };
}


herringbone_metric_transposing();


// The end.
