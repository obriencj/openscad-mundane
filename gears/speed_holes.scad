/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Some modules for cutting a "speed holes" in a gear. Due to the extra
  walls, these can actually make the gear stronger while also reducing
  material usage.
*/


use <../common/copies.scad>;
use <../common/utils.scad>;


function speed_hole_threshold() = 5;


function speed_hole_count(ring_r, hole_r) =
     let(inside_r = ring_r - hole_r,
	 theta = asin(hole_r / (hole_r + inside_r)),
	 count = floor(180 / theta))
     count;


module _speed_holes(inner_r, outer_r, spacing=2, $fn=100) {
     ring_r = inner_r + ((outer_r - inner_r) / 2);
     hole_r = (outer_r - ring_r) - spacing;

     if(hole_r > speed_hole_threshold()) {

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


module with_speed_holes(inner_r, outer_r, thick, $fn=100) {

     2d_cutout(thick, [0, 0, 0]) {
	  children();
	  #_speed_holes(inner_r, outer_r, $fn=$fn);
     };
}


// The end.
