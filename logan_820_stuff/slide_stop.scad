


function v_slide_profile_points(x=0, y=0, lip=10) =
     let(v_width=17,
	 v_height=6.6,
	 v_plateau=3.5,
	 v_riselen=(v_width - v_plateau) / 2,
	 dropdown=13)
     [[x, y],
      [x + v_riselen, y + v_height],
      [x + v_riselen + v_plateau, y + v_height],
      [x + v_width, y],
      [x + v_width, y - dropdown],
      [x, y - dropdown],
      [x - lip, y - dropdown],
      [x - lip, y - 1.5],
      [x, y - 1.5]];



module v_slide_profile(x=0, y=0, lip=10) {
     polygon(v_slide_profile_points(x, y, lip));
}


module slide_block(width, depth, height) {
     difference() {
	  linear_extrude(width) {
	       difference() {
		    square([depth, height]);
		    translate([10, 13]) {
			 v_slide_profile(lip=11);
		    };

		    // gauge holder
		    translate([depth - 8, height - 12]) {
			 translate([-0.5, 0]) {
			      square([1, height]);
			 };
			 circle(r=9.6/2, $fn=50);
		    };
	       };

	       // clamp bottom
	       translate([depth - 30, -5]) {
		    square([30, 3]);
	       };
	  };

	  // m3 screw hole for gauge clamp
	  translate([depth - 23, height - 4, width / 2]) {
	       rotate([0, 90, 0]) {
		    #cylinder(15, r=1.5, $fn=50);
	       };
	  };
	  translate([depth - 8, height - 4, width / 2]) {
	       rotate([0, 90, 0]) {
		    #cylinder(9, r=1.6, $fn=50);
	       };
	  };

	  // m6 hole for clamp bottom
	  translate([36, -1, width/2]) {
	       rotate([-90, 0, 0]) {
		    #cylinder(15, r=2.95, $fn=50);
	       };
	  };
	  translate([36, -6, width/2]) {
	       rotate([-90, , 0]) {
		    cylinder(5, r=3.1, $fn=50);
	       };
	  };
     };
}


module gauge_slide_block(width, depth, height) {
     difference() {
	  slide_block(width, depth, height);
     };
}


gauge_slide_block(20, 45, 35);


// The end.
