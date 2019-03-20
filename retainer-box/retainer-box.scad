

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
     hollow_halves(66, 48, 12, 1, 2);
     hinges(4, 8, 2, 4);

     translate([-28, 3, 5]) {
	  cube([56, 1, 4]);
     };

     dupli_rot() {
	  translate([0, -52.5, 7]) {
	       rotate([90, 0, 0])
		    clasp_half();
	  };
     };
}


retainer_box();


// The end.
