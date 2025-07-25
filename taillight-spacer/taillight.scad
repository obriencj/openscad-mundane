
use <../common/copies.scad>;


module bolt_holes(bolt_space, bolt_r, $fn=50) {
     offset = bolt_space / 2;

     translate([offset, 0, 0]) circle(r=bolt_r);
     translate([-offset, 0, 0]) circle(r=bolt_r);
}


module adapter_body(width, height, mink_r = 5) {
     translate([(-width / 2) + mink_r / 2, (-height / 2) + mink_r / 2, 0]) {
          minkowski() {
               circle(r=mink_r, $fn=50);
               square([width - mink_r, height - mink_r]);
          }
     }
}


module adapter_profile(bolt_space, rise, bolt_r, washer=2.5) {
     extra = bolt_r + washer;
     difference() {
          adapter_body(bolt_space + extra, rise + extra, extra);
          translate([0, rise / 2, 0]) {
               bolt_holes(bolt_space, bolt_r + 0.2);
          }
     }
}

module adapter(bolt_space = 50, rise = 15, bolt_r = 2.6, washer = 2.5) {
     linear_extrude(2) {
          adapter_profile(bolt_space, rise, bolt_r);
     }
     linear_extrude(4.5) {
          translate([0, -rise / 2, 0]) {
               bolt_holes(bolt_space, bolt_r-0.1);
               circle(r=bolt_r, $fn=50);
          }
          translate([0, rise / 2, 0]) {
               difference() {
                    bolt_holes(bolt_space, bolt_r+washer);
                    bolt_holes(bolt_space, bolt_r+0.2);
               }
          }
     }
}


adapter();


// The end.
