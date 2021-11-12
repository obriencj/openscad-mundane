

use <../common/copies.scad>;
use <../common/shapes.scad>;


module rectangle_tile(x, y, thick, r=5) {
     intersection() {
          translate([0, 0, -r]) {
               rounded_box(x, y, thick + r, r, $fn=100);
          };
          cube([x, y, thick]);
     }
}


module square_tile(xy, thick) {
     rectangle_tile(xy, xy, thick);
}


module single_square(xy, thick, frame_thick=5) {
     outer_xy = xy + (2 * frame_thick);

     difference() {
          cube([outer_xy, outer_xy, thick - 0.02]);
          translate([frame_thick, frame_thick, -0.01]) {
               square_tile(xy, thick);
          };
     }
}


module quad_square(xy, thick, frame_thick=5) {
     copy_grid(offsets=[xy + frame_thick, xy + frame_thick, 0],
               grid=[2, 2, 1]) {
          single_square(xy, thick, frame_thick);
     };
}


// square_tile(50, 8);
// single_square(50, 10);
mirror([0, 0, 1])
quad_square(50, 10);


// The end.
