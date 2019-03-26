

module hinge_join(width, height, standoff, count, $fn=100) {

     overall = (width + 0.1) * count * 2;

     intersection() {
	  translate([overall / -2, -standoff, 0]) {
	       cube([overall, standoff * 2, height * 2]);
	  }

	  union() {
	  children();

	  rotate([0, 0, 180]) {
	       difference() {
		    children();
		    translate([(overall / -2) + (width / 2), 0, height]) {
			 rotate([0, 90, 0]) {
			      cylinder(overall - width, 0.75, 0.75);
			 };
		    };
	       };
	  };
	  };
     };
}


module hinge_half(width, height, standoff, count=2, pin=0.5, $fn=100) {
     gap = 0.1;

     gwid = width - gap;

     locate = -(width + gap) * 2;

     barrel_r = standoff - 0.5;

     start = ceil(count / -2) + 1;
     stop = floor(count / 2);

     for(c = [start:stop]) {
	  translate([locate * c, 0, 0]) {
	       union() {
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

		    // this is the connecting pin
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
	      standoff=2, count=4, pin_r=0.5, $fn=100) {

     hinge_join(barrel_width, center_height, standoff, count) {
	  hinge_half(barrel_width, center_height, standoff, count, pin_r);
     }
}


// The end.
