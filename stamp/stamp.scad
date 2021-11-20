

use <../common/shapes.scad>;
use <../common/utils.scad>;


module stamp(word, h, w, z=1.5, $fn=100) {
     inner_h = h - 4;
     handle_r = min(h, w) / 2;
     corner_r = handle_r - 1;

     resize([inner_h, 0, z + 1], true) {
	  words([word], size=h, thick=(z + 1));
     };

     difference() {
	  translate([-h / 2, -w / 2, 0]) {
	       rounded_plate(h, w, 10, corner_r, $fn=$fn);
	  };
	  translate([-(h - 2) / 2, -(w - 2) / 2, -1]) {
	       rounded_plate(h - 2, w - 2, z + 2, corner_r - 1, $fn=$fn);
	  };
     };


     /*
     translate([0, 0, 8]) {
	  minkowski() {
	       sphere(r=handle_r / 2);
	       cylinder(r=handle_r / 2, 40);
	  };
     };
     */
}


stamp("siege", 35, 16);


// The end.
