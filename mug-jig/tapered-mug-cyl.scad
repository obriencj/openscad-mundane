

use <../bolt-knob/knob.scad>;


module mug_cyl(h=100, r=35, with_cyl=true, $fn=150) {

     grip_height = 15;
     total_height = grip_height + h;

     difference() {
          union() {
               translate([0, 0, 14]) {
                    minkowski() {
                         cylinder(h - 4, r, r-8);
                         sphere(r=5);
                    };
               };

               better_knob(15, 0, 5, 5, r + 15);
          };

          translate([0, 0, -1]) {
               cylinder(total_height + 2, r-4, r-12);
          };
     };

     if(with_cyl) {
          difference() {
               cylinder(total_height, r-4.5, r-12.5);
               translate([0, 0, -3]) {
                    cylinder(total_height, r-7, r-15);
               };
          };
          difference() {
               cylinder(2, r=r-6.5);
               translate([0, 0, -1]) {
                    cylinder(4, r=r-12);
               };
          };
     };
}


mug_cyl(80, r=35);


// The end.
