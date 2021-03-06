/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v.3

  You wouldn't download an acorn.
*/



use <../common/threads.scad>


module freecorn_threads(radius, internal=0) {
     l = internal? 1: 0;
     t = internal? 0: 0.1;
     r = internal? radius + 0.1: radius;
     metric_thread(radius * 2, 2, 5,
		   angle=50,
		   n_starts=2, leadin=l, taper=t,
		   internal=internal);
}


// these factors of width:height look most like an acorn to my
// untrained eye.
function pretty_nut_factor() = 0.65;
function pretty_hat_factor() = 2.75;


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


module threaded_acorn_nut(height, width, thick) {

     r = width / 2;
     tr = (width - 1) / 2;

     difference() {
	  union() {
	       translate([0, 0, 4.5]) {
		    acorn_nut(height, width, thick);
		    cylinder(1, r=r, $fn=100);
		    rotate([180, 0, 0]) {
			 translate([0, 0, -0.5]) {
			      freecorn_threads(tr, 0);
			 };
		    };
	       };
	  };
	  translate([0, 0, -0.5]) {
	       cylinder(9, r=r-(2 * thick), $fn=100);
	  };
     };
}


module pretty_acorn_nut(width, thick=2) {
     height = width / pretty_nut_factor();
     acorn_nut(height, width, thick);
}


module pretty_threaded_acorn_nut(width, thick=2) {
     height = width / pretty_nut_factor();
     threaded_acorn_nut(height, width, thick);
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
     tr = (width - 1) / 2;

     difference() {
	  acorn_hat(height, width, thick);
	  union() {
	       freecorn_threads(tr, 1);
	  };
     };
}


module pretty_acorn_hat(width, thick=2) {
     height = width / pretty_hat_factor();
     acorn_hat(height, width, thick);
}


module pretty_threaded_acorn_hat(width, thick=2) {
     height = width / pretty_hat_factor();
     threaded_acorn_hat(height, width, thick);
}


module pretty_threaded_acorn_keychain_hat(width, thick=2) {
     height = width / pretty_hat_factor();

     difference() {
	  threaded_acorn_hat(height, width, thick);

	  translate([0, 0, height+2.5]) {
	       rotate([-90, 0, 0]) {
		    rotate_extrude(angle=360, $fn=100) {
			 translate([4, 0]) circle(1.5, $fn=100);
		    };
	       };
	  };
     };
}


/* --- acorn combined --- */


module pretty_threaded_acorn(width) {
     pretty_threaded_acorn_hat(width);

     translate([width + 10, 0, 0])
	  pretty_threaded_acorn_nut(width);
}


module pretty_threaded_acorn_keychain(width) {
     pretty_threaded_acorn_keychain_hat(width);

     translate([width + 10, 0, 0])
	  pretty_threaded_acorn_nut(width);
}


pretty_threaded_acorn_keychain(30);


// The end.
