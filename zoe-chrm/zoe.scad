/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;


module heart(thick=3, $fn=50) {
     linear_extrude(thick) {
	  hull() {
	       translate([-8, 5, 0])
		    circle(10);

	       translate([0, -15, 0])
		    circle(2);
	  };

	  hull() {
	       translate([8, 5, 0])
		    circle(10);

	       translate([0, -15, 0])
		    circle(2);
	  };
     };
}


module charm_heart(thick=3, inset=1, $fn=50) {
     difference() {
	  union() {
	       difference() {
		    resize([50, 0, 0], auto=[true, true, false]) {
			 heart();
		    };

		    translate([0, 0, thick - inset]) {
			 resize([45, 0, 0], auto=[true, true, false]) {
			      heart();
			 };
		    };
	       };

	       translate([0, 9, 0]) {
		    children();
	       };

	       // rim around the hole
	       translate([-20, 11, 0]) {
		    cylinder(thick, 3, 3);
	       }
	  };

	  // poke a hole
	  translate([-20, 11, -1]) {
	       cylinder(thick + 2, 1.5, 1.5);
	  };
     };
}


module zoe_heart($fn=50) {
     charm_heart() {
	  words(["owo", "uwu", "owo"],
		size=8, thick=3, spacing=8);
     };
}


zoe_heart();


// The end.
