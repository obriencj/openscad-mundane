

use <shade.scad>;


module shade(thick=3, base_r=42/2, fattest=100, $fn=100) {
     fudge = 5;
     height = 130;

     translate([0, 0, height/2]) {
	  difference() {
	       translate([0, 0, -fudge]) {
		    resize(newsize=[fattest, fattest, height]) {
			 hollow_sphere(thick, fattest, $fn=50);
		    };
	       };
	       cylinder(r=(fattest + 2) /1, height / 2);
	       translate([0, 0, (-height / 2) - fudge]) {
		    cylinder(r=base_r - thick, base_r);
	       };
	  };
     };
}


module base(thick=3, r=42/2, tall=8, $fn=100) {
     difference() {
	  cylinder(tall, r=r+thick);
	  translate([0, 0, -1]) {
	       cylinder(tall + 2, r=r);
	  };
     };
}


module hanging_shade() {
     base();
     difference() {
          translate([0, 0, -3]) shade();
          translate([0, 0, -10]) cylinder(r=100, 10);
     };
}


hanging_shade();


// The end.
