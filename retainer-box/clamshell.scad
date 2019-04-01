/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;


module _curvybits(angle, height, full_r, little_r, $fn=50) {
     translate([0, 0, height-1]) {
	  linear_extrude(1) {
	       circle(full_r);
	  };
     };

     translate([0, 0, little_r]) {
	  rotate_extrude(angle=angle, $fn=100) {
	       translate([full_r - little_r, 0])
		    circle(little_r, $fn=50);
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

module _solid_vol(width, depth, height) {

     r = width / 2;

     corner_r = 5;

     hull() {
	  translate([0, depth - r, 0])
	  intersection() {
	       translate([-r, 0, 0]) {
		    cube([width, r, height]);
	       }

	       _curvybits(180, height, r, 2, 100);
	  };

	  // rounded back corners
	  translate([-r + corner_r, corner_r, 0]) {
	       rotate([0, 0, 180]) {
		    _curvybits(90, height, corner_r, 2, 50);
	       };
	  };
	  translate([r - corner_r, corner_r, 0]) {
	       rotate([0, 0, -90]) {
		    _curvybits(90, height, corner_r, 2, 50);
	       };
	  };
     };
}


module half_clamshell(width, depth, height, thick) {
     dthick = thick * 2;

     _subtract_interior(width, depth, height + 1, thick) {
	  _solid_vol(width + dthick, depth + dthick, height + thick);
     };
}


module full_clamshell(width, depth, height, thick, y_gap=2) {
     duplicate(rotate_v=[0, 0, 180]) {
	  translate([0, y_gap, 0]) {
	       half_clamshell(width, depth, height / 2, thick);
	  };
     };
}

full_clamshell(80, 50, 14, 3);


// The end.
