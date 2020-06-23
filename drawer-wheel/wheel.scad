/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v.3
*/


use <../common/shapes.scad>;


module drawer_wheel(wheel_r=12.5, lip_r=15.5, taper=1.0,
		    thick=13, lip_thick=2, hub_r=2.5,
		    $fn=150) {

     difference() {
	  union() {
	       cylinder(thick, wheel_r, wheel_r - taper);
	       cylinder(lip_thick, r=lip_r);
	  };

	  translate([0, 0, -1]) {
	       cylinder(thick + 2, r=hub_r);
	  };

	  inset = 2;
	  translate([0, 0, thick - inset]) {
	       barrel(wheel_r - taper - inset, inset + 1, hub_r + inset);
	  };
	  translate([0, 0, -inset + 1]) {
	       barrel(wheel_r - taper - inset, inset + 1, hub_r + inset);
	  };
     };
}


drawer_wheel();


// The end.
