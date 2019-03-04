

module rounded_box(width, height, thickness, turn_r=5.1, $fn=100) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  hull() {
	       cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, 0, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([0, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	  };
     };
}


module subtract_inset_same(width, height, rim, thick, inset) {

     difference() {
	  children();

	  translate([rim, rim, inset]) {
	       resize([width - (2 * rim), height - (2 * rim), thick]) {
		    children();
	       }
	  }
     };
}


module plaque_base(width=30, height=20, rim=1, thick=4, inset=1, $fn=100) {

     // magnet sizing
     magnet_d = 8.5;  // mm diameter
     magnet_h = 3.1;  // mm thickness
     magnet_r = magnet_d / 2;

     magnetc_h = 4;
     magnetc_r = magnet_r + 1;

     difference() {
	  union() {
	       difference() {
		    rounded_box(width, height, thick);
		    translate([rim, rim, inset])
			 cube([width - (2 * rim), height - (2 * rim), thick]);
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


module plaque(width=60, height=40, rim=6, thick=4, inset=1, $fn=100) {
     plaque_base(width, height, rim, thick, inset);

     offs = rim + 0.5;
     delt = (2 * rim) - 1;

     if ($children) {
	  translate([offs, offs, 0]) {
	       intersection() {
		    cube([width - delt, height - delt, thick - 0.5]);
		    // rounded_box(width - delt, height - delt, thick - 0.5);

		    children();
	       }
	  }
     }
}


// The end.
