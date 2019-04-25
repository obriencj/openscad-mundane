
module kirb(dia=8) {
     resize([dia * 2, 0, 0], auto=true) {
	  import("kirb-face.stl");
     };
}


module bust_base(height, width, thick, $fn=80) {
     h_width = width / 2;
     er = 5;

     difference() {
	  hull() {
	       translate([0, height - (width / 2), 0]) {
		    cylinder(thick, h_width, h_width, center=true);
	       };

	       translate([-(width / 2) + er, 0, 0]) {
		    cylinder(thick, er, er, center=true);
	       };

	       translate([(width / 2) - er, 0, 0]) {
		    cylinder(thick, er, er, center=true);
	       };
	  };

	  hull() {
	       translate([0, height - (width / 2), thick / 2]) {
		    cylinder(5, h_width - 2, h_width - 2, center=true);
	       };
	       translate([0, h_width, thick / 2]) {
		    cylinder(5, h_width - 2, h_width - 2, center=true);
	       };
	  };

	  hull() {
	       translate([-(width / 2) + (4 * er), -er * 2, 0]) {
		    cylinder(thick + 2, 2 * er, 2 * er, center=true);
	       };

	       translate([(width / 2) - (4 * er), -er * 2, 0]) {
		    cylinder(thick + 2, 2 * er, 2 * er, center=true);
	       };
	  };
     };
}


module kirb_inset(height=80, width=60, thick=20) {
     base = 2.5;

     difference() {
	  bust_base(height, width, thick);

	  translate([0, (height / 2.1), (thick / 2) + 1]) {
	       rotate([0, 180, 0]) {
		    kirb(width / 2.5);
	       };
	  };

	  translate([-width / 5.1, height / 1.71, -thick / 30]) {
	       cylinder(20, width / 35, width / 35, $fn=50);
	  };

	  translate([width / 7, height / 1.71, -thick / 30]) {
	       cylinder(20, width / 35, width / 35, $fn=50);
	  };
     };
}


kirb_inset(90, 80, 30);


// The end.
