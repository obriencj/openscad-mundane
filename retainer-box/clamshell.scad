/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/copies.scad>;


module _curvybits(angle, height, full_r, little_r, chamfer, $fn=100) {
     translate([0, 0, height-1]) {
	  linear_extrude(1) {
	       circle(full_r);
	  };
     };

     translate([0, 0, little_r]) {
	  rotate_extrude(angle=angle) {
	       translate([full_r - little_r, 0])
		    circle(little_r, $fn=chamfer);
	  };
     };
}


module _subtract_interior(width, depth, height, thick) {
     difference() {
	  children();

	  translate([0, thick, thick]) {
	       resize([width, depth, height]) {
		    children();
	       };
	  };
     };
}

module _solid_vol(width, depth, height, chamfer=20) {

     r = width / 2;

     corner_r = 5;

     hull() {
	  translate([0, depth - r, 0])
	  intersection() {
	       translate([-r, 0, 0]) {
		    cube([width, r, height]);
	       }

	       _curvybits(180, height, r, 2, chamfer);
	  };

	  // rounded back corners
	  translate([-r + corner_r, corner_r, 0]) {
	       rotate([0, 0, 180]) {
		    _curvybits(90, height, corner_r, 2, chamfer);
	       };
	  };
	  translate([r - corner_r, corner_r, 0]) {
	       rotate([0, 0, -90]) {
		    _curvybits(90, height, corner_r, 2, chamfer);
	       };
	  };
     };
}


module half_clamshell(width, depth, height, thick, chamfer=20) {
     dthick = thick * 2;

     _subtract_interior(width, depth, height + 1, thick) {
	  _solid_vol(width + dthick, depth + dthick, height + thick, chamfer);
     };
}


module full_clamshell(width, depth, height, thick, y_gap=2, chamfer=20) {
     duplicate(rotate_v=[0, 0, 180]) {
	  translate([0, y_gap, 0]) {
	       half_clamshell(width, depth, height / 2, thick, chamfer);
	  };
     };
}

full_clamshell(80, 50, 14, 3, y_gap=2, chamfer=4);


// The end.
