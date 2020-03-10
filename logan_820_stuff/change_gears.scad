

use <../gears/bore.scad>;
use <../gears/gears.scad>;
use <../gears/speed_holes.scad>;


function default_bore() = 5/8;
function default_thick() = 1/2;
function default_modul() = 1.5;
function default_helix(idler=false) = 30 * (idler? -1: 1);


module herringbone_change_gear(teefs, idler=false) {

     bore = default_bore();
     thick = default_thick();
     modul = default_modul();
     helix = default_helix(idler);

     thick_mm = inch_to_mm(thick);
     bore_mm = inch_to_mm(bore);

     // determine the space for the speed holes
     eng_keysize = eng_std_keysize(bore);
     inner_r = (bore_mm + inch_to_mm(eng_keysize)) / 2;
     outer_r = root_radius(modul, teefs) - 2;

     with_speed_holes(inner_r + 2, outer_r - 2, thick_mm) {
	  with_eng_std_bore(default_bore(), thick, keyed=true) {
	       herringbone_gear(modul, teefs, thick_mm, helix=helix);
	  };
     };
}


module gear_24() {
     herringbone_change_gear(24);
}


module gear_48() {
     herringbone_change_gear(48);
}


module gear_i73() {
     herringbone_change_gear(73, idler=true);
}


translate([-10, 20]) gear_24();
translate([-10, -50]) gear_48();
translate([90, 0]) gear_i73();


// The end.
