

use <../bolt-knob/knob.scad>;


module mug_cyl(h=100, r=35, $fn=150) {

     grip_height = 15;
     total_height = grip_height + h;

     difference() {
          union() {
               translate([0, 0, 14]) {
                    minkowski() {
                         cylinder(h - 4, r=r);
                         sphere(r=5);
                    };
               };

               better_knob(15, 0, 5, 5, r + 15);
          };

          translate([0, 0, -1]) {
               cylinder(total_height + 2, r=r-4);
          }
     };
}


mug_cyl(95);


// The end.
