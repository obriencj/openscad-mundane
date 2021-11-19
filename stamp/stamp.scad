

use <../common/shapes.scad>;
use <../common/utils.scad>;


module stamp(word, h, w, z=2, $fn=100) {
     inner_h = h - 6;
     handle_r = min(h, w) / 2;

     resize([inner_h, 0, z], true) {
	  words([word], size=h, thick=(z + 0.1));
     };

     difference() {
	  translate([-h / 2, -w / 2, 0]) {
	       rounded_plate(h, w, 10, 5);
	  };
	  translate([-(h - 2) / 2, -(w - 2) / 2, -1]) {
	       rounded_plate(h - 2, w - 2, z + 2, 4);
	  };
     };

     translate([0, 0, 8]) {
	  minkowski() {
	       sphere(r=handle_r / 2);
	       cylinder(r=handle_r / 2, 40);
	  };
     };
}


stamp("siege", 25, 15);


// The end.
