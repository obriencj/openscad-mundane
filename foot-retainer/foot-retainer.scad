

use <../common/copies.scad>;
use <../common/shapes.scad>;



module screw_hole(hole_r, thick) {
     union() {
          translate([0, 0, -1]) {
               cylinder(thick, r=hole_r);
          };
          translate([0, 0, thick - 1.9]) {
               cylinder(3, hole_r, hole_r + 2.5);
          };
     };
}


module toe_clip(r, h, $fn=120) {

     outer_r = r + 4;
     thick = 5;

     difference() {
          union() {
               cylinder(h, r=outer_r);
               translate([-outer_r, -outer_r - 10, 0]) {
                    rounded_plate(outer_r * 2, (outer_r * 2) + 20, thick,
                         turn_r=7.25, $fn=50);
               };
          };
          translate([0, 0, -1]) {
               cylinder(h+2, r=r);
          };

          copy_mirror([0, 1, 0]) {
               copy_mirror([1, 0, 0]) {
                    translate([outer_r - 8, outer_r + 2, -1]) {
                         screw_hole(2.75, thick);
                    };
               };
          };
     };
}


toe_clip(48 / 2, 12);


// The end.
