

use <hollow_vol.scad>;

use <hinges.scad>;

use <clasp.scad>;


module clasp_a($fn=50) {
     union() {
	  hull() {
	       translate([0, 0, -2]) {
		    cube([4, 2, 2], center=true);
	       }
	       translate([0, -1, -4]) {
		    cube([4, 1, 1], center=true);
	       }
	  };

	  difference() {
	       cube([6, 1.5, 6], center=true);

	       translate([0, 0, 2]) {
		    cube([1.5, 2, 5], center=true);
	       }
	       translate([0, 2, 1]) {
		    rotate([90, 0, 0]) {
			 cylinder(4, 1.25, 1.25);
		    };
	       }
	  }
     };
}


module clasp_b($fn=50) {
     rotate([90, 0, 0]) {
	  cylinder(3, 1, 1);
     };
}


module dupli_rot() {
     children();
     rotate([0, 0, 180]) children();
}


module retainer_box() {
     wall_thick = 1.5;

     hollow_halves(66, 48, 12, wall_thick, 2);
     hinges(4, 8, 2, 4);

     translate([-28, wall_thick + 2, 5]) {
	  cube([56, 1, 4]);
     };

     dupli_rot() {
	  translate([0, 48 + wall_thick + wall_thick + 2.2, 7]) {
	       rotate([90, 0, 180])
		    clasp_half();
	  };
     };
}


retainer_box();


// The end.
