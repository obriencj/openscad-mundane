
use <../two-sided-snap-coin/two-sided-snap-coin.scad>;

use <br-keychain.scad>;


module feather(width, thick, $fn=100) {
     resize([width, 0, 0], auto=[false, true, false]) {
	  linear_extrude(thick) {
	       import("feather.svg", center=true);
	  };
     };
}


coin(30, 4, 3) {
     feather(24, 1);

     difference() {
	  intersection() {
	       translate([-15, -7, 0]) {
		    cube([30, 14, 1]);
	       }
	       cylinder(1, 13, 13);
	  }
	  translate([0, 3, 0])
	       words(["$34 000","000 000"], thick=2, size=4.5);
     };
}
