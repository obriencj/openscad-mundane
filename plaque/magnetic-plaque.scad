/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GNU LGPL v3+
*/


use <../common/utils.scad>;


module plaque_base(width=30, height=20, rim=1, thick=4, inset=1, $fn=50) {

     // magnet sizing
     magnet_d = 8.5;  // mm diameter
     magnet_h = 3.1;  // mm thickness
     magnet_r = magnet_d / 2;

     magnetc_h = 4;
     magnetc_r = magnet_r + 1;

     i_width = width - (2 * rim);
     i_height = height - (2 * rim);

     difference() {
	  union() {
	       difference() {
		    rounded_plate(width, height, thick);
		    translate([rim, rim, thick - inset]) {
			 cube([i_width, i_height, thick]);
		    }
	       };

	       // magnet hole caps
	       translate([magnetc_r + 1, magnetc_r + 1, 0])
		    cylinder(magnetc_h, magnetc_r, magnetc_r);
	       translate([width - magnet_r - 2, magnetc_r + 1, 0])
		    cylinder(magnetc_h, magnetc_r, magnetc_r);
	       translate([width - magnet_r - 2, height - magnetc_r - 1, 0])
		    cylinder(magnetc_h, magnetc_r, magnetc_r);
	       translate([magnet_r + 2, height - magnetc_r - 1, 0])
		    cylinder(magnetc_h, magnetc_r, magnetc_r);
	  };

	  // magnet holes
	  translate([magnet_r + 2, magnet_r + 2, -1])
	       cylinder(magnet_h + 1, magnet_r, magnet_r);
	  translate([width - magnet_r - 2, magnet_r + 2, -1])
	       cylinder(magnet_h + 1, magnet_r, magnet_r);
	  translate([width - magnet_r - 2, height - magnet_r - 2, -1])
	       cylinder(magnet_h + 1, magnet_r, magnet_r);
	  translate([magnet_r + 2, height - magnet_r - 2, -1])
	       cylinder(magnet_h + 1, magnet_r, magnet_r);
     };
}


module plaque(width=60, height=40, rim=6, thick=4, inset=1, $fn=50) {
     plaque_base(width, height, rim, thick, inset);

     offs = rim + 0.5;
     delt = (2 * rim) - 1;

     if ($children) {
	  intersection() {
	       cube([width - delt, height - delt, thick - 0.5]);
	       translate([width / 2, height / 2, 0]) children();
	  };
     };
}


// The end.
