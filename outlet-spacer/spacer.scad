

use <../common/shapes.scad>;


module spacer(width=56, height=105, depth=10, oversize=24, corner_r=8) {
     d_oversize = oversize * 2;

     linear_extrude(depth) {
          difference() {
               rounded_plate(width + d_oversize,
                             height + d_oversize,
                             0, turn_r=corner_r, $fn=100);
               translate([oversize, oversize]) {
                    rounded_plate(width, height, 0, turn_r=4);
               };
          };
     };
     linear_extrude(1) {
          difference() {
               rounded_plate(width + d_oversize,
                             height + d_oversize,
                             0, turn_r=corner_r, $fn=100);
               translate([oversize + 1, oversize + 3]) {
                    rounded_plate(width - 2, height - 6, 0, turn_r=4);
               };
          };
     };
}


spacer();


// The end.
