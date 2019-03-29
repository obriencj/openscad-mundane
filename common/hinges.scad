/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


module hinge_join(width, height, standoff, count, pin=0.5, $fn=50) {

     gap = 0.1;

     // this is the bore of the hinge barrels, based on the pin size
     // plus a tiny bit extra
     pin_gap = pin + gap;

     overall = (width + gap) * count * 2;

     intersection() {
	  translate([overall / -2, -standoff, 0]) {
	       cube([overall, standoff * 2, height * 2]);
	  }

	  union() {
	       // half the hinges are normal, and include their pins
	       children();

	       // the other half of the hinges have a hole removed that
	       // is meant to accept the pin
	       rotate([0, 0, 180]) {
		    difference() {
			 children();
			 translate([(overall / -2) + (width / 2), 0, height]) {
			      rotate([0, 90, 0]) {
				   cylinder(overall - width, pin_gap, pin_gap);
			      };
			 };
		    };
	       };
	  };
     };
}


module hinge_half(width, height, standoff, count=2, pin=0.5, $fn=50) {

     // the gap is the space between the barrels, preventing them from
     // merging into a single solid object
     gap = 0.1;

     gwid = width - gap;

     locate = -(width + gap) * 2;

     barrel_r = standoff - 0.25;

     start = ceil(count / -2) + 1;
     stop = floor(count / 2);

     for(c = [start:stop]) {
	  translate([locate * c, 0, 0]) {
	       union() {
		    // is is the body of the barrel and a slanted
		    // segment that joins to the opposing parts
		    hull() {
			 translate([gap, 0, height]) {
			      rotate([0, 90, 0]) {
				   cylinder(gwid, barrel_r, barrel_r);
			      };
			 };
			 translate([gap, standoff, height - 4]) {
			      cube([gwid, 1, 1]);
			 };
		    };

		    // this is the connecting pin, driven through the
		    // whole hing, and subtracted later from half of
		    // the hinges during hinge_join
		    translate([-1, 0, height]) {
			 rotate([0, 90, 0]) {
			      cylinder(width + 2, pin, pin);
			 };
		    };
	       };
	  };
     };
}



module hinges(barrel_width=4, center_height=8,
	      standoff=2, count=4, pin_r=0.5) {

     hinge_join(barrel_width, center_height, standoff, count, pin_r) {
	  hinge_half(barrel_width, center_height, standoff, count, pin_r);
     };
}


// The end.
