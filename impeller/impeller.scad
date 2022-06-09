
use <../common/copies.scad>;


module blade(full_r, curve_r, thick, $fn=200) {
     intersection() {
          circle(full_r);
          translate([0, -curve_r]) {
               difference() {
                    scale([0.5, 1]) circle(curve_r);
                    scale([0.48, 1]) circle(curve_r-thick);
               };
          };
          translate([0, -full_r]) {
               square([full_r, full_r]);
          };
     };
}



module cross_hole_profile(outer_r=2.5, inner_r=1.00) {
     outer_d = outer_r * 2;
     inner_d = inner_r * 2;

     intersection() {
          union() {
               square([outer_d, inner_d], center=true);
               square([inner_d, outer_d], center=true);
          };
          rotate([0, 0, 45]) {
               square([outer_d, inner_d], center=true);
               square([inner_d, outer_d], center=true);
          };
     };
}


module impeller(height, thick, r, count=12, $fn=200) {
     union() {
          linear_extrude(height) {
               copy_rotate(z = (360 / count), copies = count) {
                    blade(r, (r * 0.75), thick);
               };
          };
     };
}


module top_impeller(height, base_thick, blade_thick,
                    r, inner_r, count=12, $fn=100) {
     difference() {
          union() {
               difference() {
                    impeller(height, blade_thick, r, count);
                    translate([0, 0, height - (base_thick * 3) + 0.1]) {
                         cylinder(base_thick * 3, inner_r, r * 0.8);
                    };
               };

               union() {
                    translate([0, 0, height - inner_r]) {
                         sphere(inner_r);
                    };
                    cylinder(height-inner_r, r=inner_r);
               };

               difference() {
                    union() {
                         cylinder(height-inner_r, r * 0.5, inner_r);
                         linear_extrude(base_thick) {
                              circle(r);
                         };
                    };
                    translate([0, 0, -base_thick]) {
                         cylinder(height-inner_r, r * 0.5, inner_r);
                    };

               };
          };

          translate([0, 0, -1]) {
               linear_extrude(2) {
                    copy_rotate(z=90, copies=3) {
                         translate([7.5, 0]) {
                              circle(0.52);
                         };
                    };
               };
          };
     };
}


module bottom_impeller(height, base_thick, blade_thick,
                       r, inner_r, count=12, $fn=100) {
     union() {
          impeller(height, blade_thick, r, count);
          linear_extrude(base_thick) {
               difference() {
                    circle(r);
                    circle(r * 0.55);
               };
          };
          cylinder(height, r=inner_r);

          linear_extrude(height + 0.5) {
               copy_rotate(z=90, copies=3) {
                    translate([7.5, 0]) {
                         circle(0.5);
                    };
               };
          };
     };
}


module blower_impeller(split=true) {

     offz = split? 1: 0;

     difference() {
          union() {
               translate([0, 0, 5 + offz]) {
                    top_impeller(34, 3, 3, 58, 10, 12);
               };
               bottom_impeller(5, 1, 3, 58, 10, 12);
          };
          translate([0, 0, -1]) {
               linear_extrude(20) {
                    cross_hole_profile(4.9, 2.9);
               };
          };
     };
}


blower_impeller();

//impeller(3, 3, 58);


/*
difference() {
     linear_extrude(4) square(15, true);
     translate([0, 0, -1]) {
          linear_extrude(20) {
               cross_hole_profile(4.9, 2.9);
          };
     };
}
*/


// The end.
