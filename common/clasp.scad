/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


module clasp_half($fn=50) {

     // this is the primary positioning translation, tweak this for
     // better clasping action.
     tweak_x = 1.80;
     tweak_y = 0.82;

     union() {
	  translate([tweak_x, tweak_y, 0]) {
	       hull() {
		    // the catch itself
		    cylinder(2, 2, 2);

		    // the connecting slant from the catch to the
		    // anchor
		    translate([1, -2.5, 0]) {
			 cylinder(1, 1, 1);
		    };
	       };
	       // cylinder anchor into back plate
	       translate([1, -2.5, -1]) {
		    cylinder(1, 1, 1);
	       };
	  };

	  // backing plate half-circle
	  translate([0, 0, -1.1]) {
	       intersection() {
		    translate([0, -4, 0])
			 cube([10, 8, 2], center=true);
		    cylinder(2, 4.5, 4.5);
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
