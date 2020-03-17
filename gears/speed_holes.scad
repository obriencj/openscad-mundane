/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Some modules for cutting a "speed holes" in a gear. Due to the extra
  walls, these can actually make the gear stronger while also reducing
  material usage.
*/


use <../common/copies.scad>;
use <../common/utils.scad>;


function speed_hole_r_threshold() = 3;


function speed_hole_count(ring_r, hole_r) =
     let(inside_r = ring_r - hole_r,
	 theta = asin(hole_r / (hole_r + inside_r)),
	 count = floor(180 / theta))
     count;


module speed_holes_profile(inner_r, outer_r, spacing=2, $fn=100) {
     ring_r = inner_r + ((outer_r - inner_r) / 2);
     hole_r = (outer_r - ring_r) - spacing;

     if(hole_r > speed_hole_r_threshold()) {

	  // count of holes (without spacing) that fir around the ring
	  holes = speed_hole_count(ring_r, hole_r + spacing);
	  hole_degrees = 360 / holes;

	  // this is just so that the keyway will be offset from any
	  // holes
	  turn = (holes % 2) ? 0: hole_degrees / 2;

	  copy_rotate(z=hole_degrees, copies=(holes - 1)) {
	       rotate([0, 0, turn]) {
		    translate([0, -ring_r]) {
			 circle(hole_r);
		    };
	       };
	  };
     };
}


module with_speed_holes(inner_r, outer_r, thick, spacing=2, $fn=100) {
     2d_cutout(thick, [0, 0, 0]) {
	  union() {
	       children();
	  };
	  speed_holes_profile(inner_r, outer_r, spacing, $fn=$fn);
     };
}


module speed_ring(inner, outer, gap, thick, $fn=100) {
     linear_extrude(thick) {
	  difference() {
	       circle(outer);
	       circle(inner);
	       speed_holes_profile(inner, outer, gap, $fn=$fn);
	  };
     };
}


speed_ring(50, 80, 4, 10);


// The end.
