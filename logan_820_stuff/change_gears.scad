

use <../gears/bore.scad>;
use <../gears/gears.scad>;


function default_bore() = 5/8;
function default_thick() = 3/4;
function default_modul() = 1.5;
function default_helix(idler=false) = 30 * (idler? -1: 1);


module herringbone_change_gear(teefs, idler=false) {
     bore = default_bore();
     thick = default_thick();
     modul = default_modul();
     helix = default_helix(idler);

     with_eng_std_bore(default_bore(), thick, keyed=true) {
	  herringbone_gear(modul, teefs, inch_to_mm(thick), helix=helix);
     };
}


module gear_24() {
     herringbone_change_gear(24);
}


module gear_48() {
     herringbone_change_gear(48);
}


module gear_i75() {
     herringbone_change_gear(75, idler=true);
}


translate([-10, 20]) gear_24();
translate([-10, -50]) gear_48();
translate([90, 0]) gear_i75();


// The end.
