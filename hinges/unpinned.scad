

use <hinges.scad>;


module unpinned_join(width, height, standoff, count, pin=0.5,
		     gap=0.1, pin_gap=0.25, $fn=50) {

     // this is the bore of the hinge barrels, based on the pin size
     // plus a tiny bit extra
     bore_r = pin + pin_gap;

     overall = (width + gap) * count * 2;

     intersection() {
	  translate([overall / -2, -standoff, 0]) {
	       cube([overall, standoff * 2, height * 2]);
	  }

	  difference() {
	       union() {
		    children();
		    rotate([0, 0, 180]) {
			 children();
		    };
	       };

	       translate([(overall / -2) + (width / 2), 0,
			  height - 0]) {
		    rotate([0, 90, 0]) {
			 cylinder(overall, bore_r, bore_r);
		    };
	       };
	  };
     };
}


module unpinned_hinges(barrel_width=4, center_height=8,
		       standoff=2, count=5, pin_r=0.5) {

     unpinned_join(barrel_width, center_height, standoff, count, pin_r) {
	  hinge_half(barrel_width, center_height, standoff,
		     count, pin=0);
     };

};


difference() {
     unpinned_hinges(4, 10, 2, 4);

     // a little cut-away for debugging
     translate([0, -3, 10]) {
	  cube([17, 6, 2]);
     };
};


// The end.
