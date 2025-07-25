
use <../common/copies.scad>;


module bolt_holes(bolt_space, bolt_r, $fn=50) {
     offset = bolt_space / 2;

     translate([offset, 0, 0]) circle(r=bolt_r);
     translate([-offset, 0, 0]) circle(r=bolt_r);
}


module adapter_body(width, height) {
     translate([-width / 2, -height / 2, 0]) {
          minkowski() {
               circle(r=5, $fn=50);
               square([width-2.5, height-2.5]);
          }
     }
}


module adapter_profile(bolt_space, rise, bolt_r) {
     extra = 10;
     difference() {
          adapter_body(bolt_space + extra, rise + extra);
          translate([0, rise / 2, 0]) {
               bolt_holes(bolt_space, bolt_r);
          }
     }
}

module adapter(bolt_space = 50, rise = 15, bolt_r = 2.6) {
     linear_extrude(2) {
          adapter_profile(bolt_space, rise, bolt_r);
     }
     linear_extrude(5) {
          translate([0, -rise / 2, 0]) {
               bolt_holes(bolt_space, bolt_r-0.1);
               circle(r=bolt_r, $fn=50);
          }
          translate([0, rise / 2, 0]) {
               difference() {
                    bolt_holes(bolt_space, bolt_r+2);
                    bolt_holes(bolt_space, bolt_r);
               }
          }
     }
}


adapter();


// The end.
