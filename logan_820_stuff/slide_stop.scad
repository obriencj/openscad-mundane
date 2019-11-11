


function v_slide_profile_points(x=0, y=0, lip=10) =
     let(v_width=17,
	 v_height=6,
	 v_plateau=4,
	 v_riselen=(v_width - v_plateau) / 2,
	 dropdown=13)
     [[x, y],
      [x + v_riselen, y + v_height],
      [x + v_riselen + v_plateau, y + v_height],
      [x + v_width, y],
      [x + v_width, y - dropdown],
      [x, y - dropdown],
      [x - lip, y - dropdown],
      [x - lip, y],
      [x, y]];



module v_slide_profile(x=0, y=0, lip=10) {
     polygon(v_slide_profile_points(x, y, lip));
}


module slide_block(width, depth, height) {
     linear_extrude(width) {
	  difference() {
	       square([40, 30]);
	       translate([10, 13]) {
		    v_slide_profile(lip=11);
	       };
	  };
     };
}


slide_block(20, 40, 50);


// The end.
