/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;


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


module keychain_base(width=60, height=30, thick=1.5, rim=2, $fn=80) {

     bend_d = height;
     bend_r = bend_d / 2;

     border_inset(width, height, thick, inset=0.25, rim=1) {
	  translate([bend_r, bend_r, 0]) {
	       linear_extrude(thick) {
		    hull() {
			 circle(bend_r);
			 translate([width - bend_d, 0, 0]) {
			      circle(bend_r);
			 };
		    };
	       };
	  };
     };
}



module simple_keychain(width, height, thick, $fn=50) {
     hole_r = height / 8;

     h_thick = thick / 2;

     // this shifts the children along the X axis past the hole
     child_offset = (width / 2) + hole_r;

     difference() {
	  double_sided(height, thick) {
	       difference() {
		    keychain_base(width, height, h_thick);
		    translate([child_offset, height / 2, h_thick]) {
			 children();
		    };
	       };
	  };

	  // poke a hole with a rim
	  translate([hole_r + 3, height / 2, -1]) {
	       cylinder(thick + 2, hole_r, hole_r);
	  };
     };
}



// The end.
