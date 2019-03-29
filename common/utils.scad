/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3+
*/



module duplicate(move_v=[0,0,0], rotate_v=[0,0,0]) {
     children();
     translate(move_v) {
	  rotate(rotate_v) {
	       children();
	  };
     };
}


module rounded_plate(width, height, thickness, turn_r=5.1, $fn=50) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  linear_extrude(thickness) {
	       minkowski() {
		    square([width - turn_d, height - turn_d]);
		    circle(turn_r);
	       };
	  };
     };
}


// The end.
