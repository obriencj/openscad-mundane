/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


module clasp_half($fn=50) {

     union() {
	  // backing plate half-circle and lip
	  translate([0, 0, -1]) {
	       intersection() {
		    translate([0, -4, 1]) {
			 cube([10, 8, 2], center=true);
		    };
		    union() {
			 cylinder(1, 4.5, 4.5);
			 translate([-3.5, -0.5, 1]) {
			      rotate([90, 0, 90]) {
				   cylinder(3, 0.5, 0.5);
			      };
			 };
		    };
	       };
	  };

	  translate([1, 1, 0]) {
	       difference() {
		    union() {
			 // the catch itself
			 hull() {
			      translate([1, -0.5, 0]) {
				   cylinder(2, 2, 2);
			      };
			      translate([1, -1, 0]) {
				   cylinder(2, 2, 2);
			      };
			 };
			 // connecting slant for catch
			 hull() {
			      translate([1, -1, 0]) {
				   cylinder(2, 2, 2);
			      };
			      translate([1, -2.5, 0]) {
				   cylinder(0.1, 2, 2);
			      };
			 };
		    };

		    // the negative space for the lip to get caught in
		    translate([-4.5, -0.5, 0]) {
			 rotate([90, 0, 90]) {
			      cylinder(9, 0.6, 0.6);
			 };
		    };

		    // a bit of space to make it easier
		    translate([-1.5, -0.5, -0.6]) {
			 cube([5, 4, 1]);
		    };
	       };
	  };
     };

}


// For debugging, render a pair of clasp halves, with the second
// highlighted


module dupl_flip() {
     children();
     #rotate([0, 0, 180]) children();
}


dupl_flip() {
     clasp_half();
};


// The end.
