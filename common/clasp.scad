


$fn = 50;


module dupl_flip(spacing=0) {
     children();
     #translate([0, -spacing, 0])
	  rotate([0, 0, 180]) children();
}


module clasp_half() {
     union() {
	  translate([1.75, 1, 0]) {
	       hull() {
		    cylinder(2, 2, 2);
		    translate([1, -3, 0]) {
			 cylinder(1, 1, 1);
		    };
	       };
	       translate([1, -3, -1]) {
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
