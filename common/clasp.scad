/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


module dupl_flip(spacing=0) {
     children();
     #translate([0, -spacing, 0])
	  rotate([0, 0, 180]) children();
}


module clasp_half($fn=50) {
     union() {
	  translate([1.5, 1.25, 0]) {
	       hull() {
		    cylinder(2, 2, 2);
		    translate([1, -2.5, 0]) {
			 cylinder(1, 1, 1);
		    };
	       };
	       translate([1, -2.5, -1]) {
		    cylinder(1, 1, 1);
	       };
	  };

	  translate([0, 0, -1.1]) {
	       intersection() {
		    translate([0, -4, 0])
			 cube([10, 8, 2], center=true);
		    cylinder(2, 4.5, 4.5);
	       };
	  };
     };

}


dupl_flip(0) {
     clasp_half();
};


// The end.
