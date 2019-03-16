

use <hollow_vol.scad>;

use <hinges.scad>;


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


module retainer_box() {
     hollow_halves(66, 48, 12, 1, 2);
     hinges(4, 8, 2, 4);

     translate([-28, 3, 5]) {
	  cube([56, 1, 4]);
     };

     translate([0, -51, 6]) {
	  clasp_b();
     };

     difference() {
	  translate([0, 52.8, 9]) {
	       clasp_a();
	  };
	  /*
	  #translate([0, 0, 16])
	  rotate([180, 0, 0]) {
	  translate([0, -51, 6]) {
	  clasp_b();
	  };
	  };
	  */
     };
}


retainer_box();


// The end.
