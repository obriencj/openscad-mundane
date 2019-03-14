
$fn = 100;


module vol(width, depth, height) {

     r = width / 2;

     hull() {
	  translate([0, depth - r, 0])
	  intersection() {
	       cylinder(height, r, r);
	       translate([-r, 0, 0])
		    cube([width, r, height]);
	  }

	  translate([width / -2, 0, 0])
	       cube([width, 1, height]);
     }

}


module hollow_vol(width, depth, height, thick) {
     dthick = thick * 2;
     difference() {
	  vol(width + dthick, depth + dthick, height + dthick);
	  translate([0, thick, thick])
	       vol(width, depth, height);
     }
}


module duplirot() {
     children();
     rotate([0, 0, 180]) children();
}


module hinge_split(x, y, z) {
     duplirot() {
	  translate([0, 0.5, 0]) {
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
	  translate([0, -1.5, 0])
	       cube([4, 2.5, 2]);

	  difference() {
	       cube([4, 1, 5]);
	       translate([1.5, -0.5, 2]) {
		    cube([1, 2, 5]);
	       }
	       translate([2, 2, 3.5]) {
		    clasp_b();
		    rotate([90, 0, 0]) {
			 cylinder(4, 1, 1);
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
     hinge_split(67, 49, 14) {
	  hollow_vol(65, 47, 12, 1);
     };

     translate([-25, -1, 6.5]) {
	  cube([10, 2, 0.25]);
     };
     translate([15, -1, 6.5]) {
	  cube([10, 2, 0.25]);
     };

     translate([-30, 1.5, 5]) {
	  cube([60, 1, 4]);
     };

     translate([-2, 49.5, 5.5]) {
	  clasp_a();
     };

     translate([0, -48, 5.5]) {
	  clasp_b();
     };
}


// The end.
