

module curvybits(angle, height, full_r, little_r, $fn=50) {
     translate([0, 0, little_r])
	  cylinder(height - (little_r * 2), full_r, full_r);

     translate([0, 0, little_r])
     rotate_extrude(angle=angle) {
	  translate([full_r - little_r, 0])
	       circle(little_r, $fn=20);
     }
}


module _vol(width, depth, height) {

     r = width / 2;

     corner_r = 5;

     hull() {
	  translate([0, depth - r, 0])
	  intersection() {
	       curvybits(180, height, r, 2, 100);
	       // cylinder(height, r, r);
	       translate([-r, 0, 0]) {
		    cube([width, r, height]);
	       }
	  };

	  // rounded back corners
	  translate([-r + corner_r, corner_r, 0]) {
	       rotate([0, 0, 180]) {
		    curvybits(90, height, corner_r, 2, 50);
	       };
	       // cylinder(height, corner_r, corner_r);
	  };
	  translate([r - corner_r, corner_r, 0]) {
	       rotate([0, 0, -90]) {
		    curvybits(90, height, corner_r, 2, 50);
	       };
	       // cylinder(height, corner_r, corner_r);
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
     fudge = thick * 2;
     vol_split(width + fudge, depth + fudge, height + fudge, y_gap) {
	  hollow_vol(width, depth, height, thick);
     };
}


hollow_halves(80, 50, 10, 3);
//curvybits(10, 40, 4);


// The end.
