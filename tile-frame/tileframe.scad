

use <../common/copies.scad>;
use <../common/shapes.scad>;


module rectangle_rounded_tile(x, y, thick, r) {
     overthick = thick + (2 * r);
     intersection() {
          translate([0, 0, -(overthick - thick)]) {
               rounded_box(x, y, overthick, r, $fn=100);
          };
          cube([x, y, thick]);
     }
}


module square_rounded_tile(xy, thick, r) {
     rectangle_rounded_tile(xy, xy, thick, r);
}


module single_square_rounded(xy, thick, r, frame_thick=5) {
     outer_xy = xy + (2 * frame_thick);
     inner_xy = xy - (2 * r);

     difference() {
          cube([outer_xy, outer_xy, (thick + frame_thick)]);

	  translate([frame_thick + r, frame_thick + r, 0.01]) {
	       rounded_plate(inner_xy, inner_xy,
			     thick + frame_thick, r,
			     $fn=100);
	  };

          translate([frame_thick, frame_thick, -0.01]) {
               square_rounded_tile(xy, thick, r);
          };
     }
}


module quad_square_rounded(xy, thick, r, frame_thick=5) {
     copy_grid(offsets=[xy + frame_thick, xy + frame_thick, 0],
               grid=[2, 2, 1]) {
          single_square_rounded(xy, thick, r, frame_thick);
     };
}


module single_square_rounded_frame_plate(xy, thick, r, frame_thick=5) {
     inner_xy = xy - (2 * r);
     rounded_plate(inner_xy, inner_xy,
		   frame_thick, r,
		   $fn=100);
}


module embossed(image, xy, thick, r, frame_thick=5) {
     difference() {
	  single_square_rounded_frame_plate(50, 8, 5);
	  translate([20, 20, 6]) {
	       mirror([1, 0, 0]) {
		    mirror([0, 0, 1]) {
			 resize([40.01, 40.01, 2])
			      surface(file=image, center=true, $fn=100);
			 };
		    };
	       };
     };
}


// square_rounded_tile(50, 5, 5);

mirror([0, 0, 1]) quad_square_rounded(50, 5, 5);

// translate([-80, 0, 0]) single_square_rounded_frame_plate(50, 5, 5);
// embossed("smoosh.png", 50, 5, 5);


// The end.
