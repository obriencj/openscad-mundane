

$fn = 100;


module _vol(width, depth, height) {

     r = width / 2;

     corner_r = 5;

     hull() {
	  translate([0, depth - r, 0])
	  intersection() {
	       cylinder(height, r, r);
	       translate([-r, 0, 0]) {
		    cube([width, r, height]);
	       }
	  };

	  // rounded back corners
	  translate([-r + corner_r, corner_r, 0]) {
	       cylinder(height, corner_r, corner_r);
	  };
	  translate([r - corner_r, corner_r, 0]) {
	       cylinder(height, corner_r, corner_r);
	  };
     };
}


module hollow_vol(width, depth, height, thick) {
     dthick = thick * 2;
     difference() {
	  _vol(width + dthick, depth + dthick, height + dthick);
	  translate([0, thick, thick])
	       _vol(width, depth, height);
     }
}



module dupli_rot(rotv) {
     children();
     rotate(rotv) children();
}


module vol_split(x, y, z, gap) {
     dupli_rot([0, 0, 180]) {
	  translate([0, gap, 0]) {
	       intersection() {
		    translate([x / -2, 0, 0])
			 cube([x, y, z / 2]);
		    union() children();
	       }
	  }
     }
}


module hollow_halves(width, depth, height, thick, y_gap=2) {
     vol_split(width + y_gap, depth + y_gap, height + y_gap, y_gap) {
	  hollow_vol(width, depth, height, thick);
     };
}


// The end.
