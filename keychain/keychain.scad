

module border_inset(width, height, thick, inset, rim) {
     difference() {
	  children();

	  translate([rim, rim, thick - inset]) {
	       resize([width - (rim * 2), height - (rim * 2), thick]) {
		    difference() {
			 children();
			 translate([rim, rim, 0]) {
			      resize([width - 2, height - 2, thick - 0.5]) {
				   children();
			      };
			 };

		    };
	       };
	  };
     };
}


module keychain_base(width=60, height=30, thick=1.5, rim=2, $fn=50) {

     border_inset(width, height, thick, inset=0.25, rim=1) {
	  hull() {
	       translate([height / 2, height / 2, 0]) {
		    cylinder(thick, height / 2, height / 2);
	       };
	       translate([width - (height / 2), height / 2, 0]) {
		    cylinder(thick, height / 2, height / 2);
	       };
	  };
     };
}


module conjoin(height, thickness) {
     union() {
	  translate([0, 0, thickness / 2]) {
	       children();
	  };
	  translate([0, height, thickness / 2])
	  rotate([180, 0, 0]) {
	       children();
	  };
     };
}


module simple_keychain(width, height, thick, $fn=50) {
     hole_r = height / 8;

     difference() {
	  conjoin(height, thick) {
	       difference() {
		    keychain_base(width, height, thick / 2);
		    children();
	       };
	  };

	  // poke a hole with a rim
	  translate([hole_r + 3, height / 2, -1]) {
	       cylinder(thick + 2, hole_r, hole_r);
	  };
     };
}


module simpler_keychain(width, height, thick, $fn=50) {
     hole_r = height / 8;

     difference() {
	  keychain_base(width, height, thick);

	  duplimove(rot_v=[180, 0, 0]) {
	       translate([width / 2, height / 2, thick]) {
		    children();
	       };
	  };

	  // poke a hole
	  translate([holr_r + 3, height / 2, -1]) {
	       cylinder(thick + 2, hole_r, hole_r);
	  }
     };
}



// The end.
