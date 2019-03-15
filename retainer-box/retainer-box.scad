
$fn = 100;


module vol(width, depth, height) {

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
	  vol(width + dthick, depth + dthick, height + dthick);
	  translate([0, thick, thick])
	       vol(width, depth, height);
     }
}


module hinge_half(width, height, standoff, count=2, pin=0.5) {
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


module dupli_move(dest) {
     children();
     translate(dest) children();
}


module duple_move_n(dests) {
     children();
     for(d = dests) {
	  translate(d) children();
     }
}


module dupli_rot(rotv) {
     children();
     rotate(rotv) children();
}


module hinge_join(width, height, standoff, count) {

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

module hinge_split(x, y, z, gap) {
     dupli_rot([0, 0, 180]) {
	  translate([0, gap, 0]) {
	       intersection() {
		    translate([x / -2, 0, 0])
			 cube([x, y, z / 2]);
		    children();
	       }
	  }
     }
}


module clasp_a() {
     union() {
	  hull() {
	       translate([0, 0, -2]) {
		    cube([4, 2, 2], center=true);
	       }
	       translate([0, -1, -4]) {
		    cube([4, 1, 1], center=true);
	       }
	  };

	  difference() {
	       cube([6, 1.5, 6], center=true);

	       translate([0, 0, 2]) {
		    cube([1.5, 2, 5], center=true);
	       }
	       translate([0, 2, 1]) {
		    rotate([90, 0, 0]) {
			 cylinder(4, 1.25, 1.25);
		    };
	       }
	  }
     };
}


module clasp_b() {
     rotate([90, 0, 0]) {
	  cylinder(3, 1, 1);
     };
}


union() {
     hinge_split(70, 52, 16, 2) {
	  union() {
	       hollow_vol(66, 48, 12, 1);
	  };
     };

     // the height of the hinge needs to be half of the height of the
     // components, or it won't close
     hinge_join(4, 8, 2, 4) {
	  hinge_half(4, 8, 2, 4);
     }

     translate([-28, 3, 5]) {
	  cube([56, 1, 4]);
     };

     translate([0, -51, 6]) {
	  clasp_b();
     };

     difference() {
	  translate([0, 52.8, 9]) {
	       clasp_a();
	  };
	  /*
	  #translate([0, 0, 16])
	  rotate([180, 0, 0]) {
	       translate([0, -51, 6]) {
		    clasp_b();
	       };
	  };
	  */
     };
}


// The end.
