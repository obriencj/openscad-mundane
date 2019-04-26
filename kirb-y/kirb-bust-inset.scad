/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GNU LGPL v3+
*/


module kirb_face(dia=16) {
     resize([dia, 0, 0], auto=true) {
	  import("kirb-face.stl");
     };
}


module bust_base(height, width, thick, $fn=80) {
     h_width = width / 2;

     er = 5;  // the radius of the bottom bends, plus used in
	      // determining the spacing of the feet.

     difference() {

	  // Simple rounded tombstone from three cylinders
	  hull() {
	       translate([0, height - h_width, 0]) {
		    cylinder(thick, r=h_width, center=true);
	       };

	       translate([-h_width + er, 0, 0]) {
		    cylinder(thick, r=er, center=true);
	       };

	       translate([h_width - er, 0, 0]) {
		    cylinder(thick, r=er, center=true);
	       };
	  };

	  // subtract a decorative inset on the face of the tombstone
	  hull() {
	       translate([0, height - h_width, thick / 2]) {
		    cylinder(5, r=h_width - 2, center=true);
	       };
	       translate([0, h_width, thick / 2]) {
		    cylinder(5, r=h_width - 2, center=true);
	       };
	  };

	  // subtract a curved area from the base of the tombstone to
	  // give it legs for a more stable base (flat bases suck)
	  hull() {
	       translate([-(width / 2) + (4 * er), -er * 2, 0]) {
		    cylinder(thick + 2, r=2 * er, center=true);
	       };

	       translate([(width / 2) - (4 * er), -er * 2, 0]) {
		    cylinder(thick + 2, r=2 * er, center=true);
	       };
	  };
     };
}


module kirb_inset(height=80, width=60, thick=20) {
     difference() {
	  // Take the base
	  bust_base(height, width, thick);

	  // Subtract a Kirb face
	  translate([0, (height / 2.1), (thick / 2) + 1]) {
	       rotate([0, 180, 0]) {
		    kirb_face(width / 1.25);
	       };
	  };

	  // I should put these in the kirb module. The model for the
	  // kirb face has big inset eyes, which turn into big outset
	  // globs when inverted like we're doing. So these cylinders
	  // are painstakingly put into place as shoddily as possible
	  // to clip those globs.
	  #translate([-width / 5.1, height / 1.74, -thick / 30]) {
	       cylinder(10, r=width / 32, $fn=50);
	  };
	  translate([width / 7, height / 1.74, -thick / 30]) {
	       cylinder(10, r=width / 32, $fn=50);
	  };
     };
}


kirb_inset(90, 80, 30);


// The end.
