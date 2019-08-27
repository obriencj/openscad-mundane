/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v.3
*/



// GPL v3 Threading module for OpenSCAD
// http://dkprojects.net/openscad-threads/
use <threads.scad>;


pretty_nut_factor = 0.65;
pretty_hat_factor = 2.75;


/* --- acorn nut --- */


module acorn_nut_curve(height, width, thick, $fn=100) {
     factor = width / height;

     r = height / 2;

     intersection() {
	  scale([factor, 1, 1]) {
	       difference() {
		    circle(r);

		    // flat bottom to avoid some print stringiness
		    intersection() {
			 circle(r - thick);
			 square([r, r - 2*thick]);
		    }
	       };
	  };
	  square([r, r]);
     };
}


module acorn_nut(height, width, thick) {
     rotate_extrude(angle=360, $fn=100) {
	  acorn_nut_curve(height, width, thick);
     };
}


module pretty_acorn_nut(width, thick=2) {
     height = width / pretty_nut_factor;
     acorn_nut(height, width, thick);
}


/* --- acorn hat --- */


module acorn_hat_curve(height, width, thick=2, $fn=100) {

     overtall = height * 1.5;
     factor = overtall / width;
     undercap = height / 4;
     r = width / 2;

     intersection() {
	  difference() {
	       translate([0, undercap, 0]) {
		    scale([1, factor, 1]) {
			 circle(r + thick);
		    };
	       };
	  };
	  square([r + thick, r]);
     };
}


module acorn_hat(height, width, thick, $fn=100) {
     rotate_extrude(angle=360, $fn=100) {
	  acorn_hat_curve(height, width, thick);
     };
     translate([0, 0, height]) {
	  cylinder(2, r=2, $fn=50);
     };
}


module threaded_acorn_hat(height, width, thick, $fn=100) {

     r = width / 2;
     difference() {
	  acorn_hat(height, width, thick);
	  union() {
	       translate([0, 0, -0.5]) {
		    cylinder(1, r=r);
	       };
	       translate([0, 0, 0.5]) {
		    freecorn_threads(r, 1);
	       };
	  };
     };
}


module pretty_acorn_hat(width, thick=2) {
     height = width / pretty_hat_factor;
     acorn_hat(height, width, thick);
}


module pretty_threaded_acorn_hat(width, thick=2) {
     height = width / pretty_hat_factor;
     threaded_acorn_hat(height, width, thick);
}


module threaded_acorn(height, width, ratio, thick=2) {

     difference() {
	  union() {
	       translate([0, 0, 5]) {
		    acorn_nut(height, ratio);
		    rotate([0, 180, 0]) {
			 freecorn_threads(width, 0);
		    };
	       };
	  };

	  translate([0, 0, -0.5]) {
	       cylinder(9, r=(width - thick - 0.5), $fn=100);
	  };
     };
}


module threaded_hat(width, ratio, thick=2) {

     difference() {
	  acorn_hat(width + thick, ratio, 2);
	  translate([0, 0, -0.5])
	       cylinder(1, r=width, $fn=100);
	  translate([0, 0, 0.5])
	       freecorn_threads(width, 1);
     };
}


module freecorn_threads(radius, internal=0) {
     metric_thread(radius * 2, 2, 5,
		   angle=45,
		   n_starts=2, leadin=1,
		   internal=internal);
}


module threaded_freecorn(height=30, ratio=0.65, thick=2) {

     width = (height * ratio);

     translate([width * 2.2, 0, 0]) {
	  threaded_acorn(height, width, 0.65, thick);
     };

     threaded_hat(width, 0.4, thick);
}



pretty_threaded_acorn_hat(30);



// The end.
