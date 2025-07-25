
use <../gears/speed_holes.scad>;
use <../common/utils.scad>;


module round_grate(r, hole_r) {

     step = (hole_r * 2) + 1;

     intersection() {
          circle(r=r, $fn=100);

          for(xi = [0:r / step]) {
               for(yi = [0:r / step]) {
                    let(x = (step * xi),
                        y = (step * yi) + (xi % 2) * step / 2) {

                         translate([x, y]) circle(hole_r, $fn=6);
                         translate([x, -y]) circle(hole_r, $fn=6);
                         translate([-x, -y]) circle(hole_r, $fn=6);
                         translate([-x, y]) circle(hole_r, $fn=6);
                    };
               };
          };
     };
}


module with_round_grate(grate_r, hole_r) {
     difference() {
          union() {
               children();
          };
          round_grate(r=grate_r, hole_r=hole_r);
     };
}


module pot_riser(r=60, grate_r=40, hole_r=3, $fn=100) {
     linear_extrude(4) {
          with_round_grate(grate_r, hole_r=hole_r) {
               circle(r=r);
          };
     };
     linear_extrude(8) {
          speed_holes_profile(grate_r-2, r+2, 2);
     };
}


module stay_ring(r=60, thick=5, $fn=100) {
     linear_extrude(thick-2) {
          difference() {
               circle(r=r+2);
               circle(r=r-2);
          }
     }
     linear_extrude(thick) {
          difference() {
               circle(r=r+2);
               circle(r=r+0.1);
          }
     }
}


pot_riser(r=90, grate_r=50);

translate([0, 0, -20]) {
     stay_ring(r=90);
}


// The end.
