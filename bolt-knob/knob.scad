

use <../common/copies.scad>;
use <../common/shapes.scad>;


function ring_hole_count(ring_r, hole_r) =
     let(inside_r = ring_r - hole_r,
         theta = asin(hole_r / (hole_r + inside_r)),
         count = floor(180 / theta))
     count;


function rotate_point(p, angle, c=[0, 0]) =
     [cos(angle) * (p.x - c.x) - sin(angle) * (p.y - c.y) + c.x,
      sin(angle) * (p.x - c.x) + cos(angle) * (p.y - c.y) + c.y,
      p[2]];


function knob_points(r1=20, r2=14, c=4, steps=6) =
     let(space = (r1 + r2) / steps,
	 o_ths = -360 / steps,
	 i_ths = o_ths / 2,
	 outie = [0, r1 - c, c],
	 innie = [0, r2 + c, -c])
     [for(i=[1:steps])
	       let(step_angle = o_ths * i)
		    for(p=[rotate_point(outie, step_angle),
			   rotate_point(innie, step_angle + i_ths)])
			 p];


module bolt_knob(thick=10, recess=4, bolt_r=3.1, hex_r=5.8, proud=2,
		 r1=20, r2=14, r3=18, c=4, steps=6) {
     difference() {
	  intersection() {
	       rounded_outset_poly(knob_points(r1, r2, c, steps),
				   5, thick, recess);
	       cylinder(thick, r=r3, $fn=100);
	  };
	  translate([0, 0, -1]) {
	       cylinder(recess + 1, r=hex_r, $fn=6);
	  };
	  translate([0, 0, -1]) {
	       cylinder(thick, r=bolt_r, $fn=60);
	  };
     };
     translate([0, 0, thick - recess]) {
	  barrel(hex_r, recess + proud, bolt_r);
     };
}


module smooth_inset(inner_r, outer_r, inset, inner_inset=0, $fn=100) {

     space = outer_r - inner_r;
     mid_r = inner_r + (space / 2);

     curve_r = space / 4;
     place_off = curve_r / 6;

     small_r = curve_r - place_off;
     big_r = curve_r + place_off;

     points = [[0, -inner_inset, 0],
	       [0, 1, 0],
	       [mid_r, big_r - inset, big_r],
	       [outer_r + 1, 1, 0],
	       [outer_r + 1, 0, 0],
	       [outer_r, -small_r, -small_r],
	       [mid_r, big_r - inset, big_r],
	       [inner_r, -small_r - inner_inset, -small_r]];


     rotate_extrude(angle=360) {
	  rounded_polygon(points);
     };
}


module better_knob(thick, hex_recess, hex_r, bolt_r,
		   outer_r, inner_r=0, grip_r=0, grip_gap=0,
		   hex_inset=0, smooth_inset=0) {

     inner_r_ = inner_r? inner_r: outer_r - 5;
     grip_r_ = grip_r? grip_r: (outer_r - inner_r_) * 2;
     grip_gap_ = grip_gap? grip_gap: grip_r_ / 4;

     // the radius we'll place the subtracted circles at, which is
     // just the inner radius plus the radius of the circles
     ring_r = inner_r_ + grip_r_;

     grip_count = ring_hole_count(ring_r, grip_r_ + grip_gap_);
     grip_degrees = 360 / grip_count;

     difference() {
	  linear_extrude(thick) {
	       difference() {
		    circle(outer_r, $fn=100);

		    circle(bolt_r, $fn=80);

		    copy_rotate(z=grip_degrees, copies=(grip_count - 1)) {
			 translate([0, ring_r]) {
			      circle(grip_r_, $fn=80);
			 };
		    };
	       };
	  };

	  if(smooth_inset) {
	       translate([0, 0, thick]) {
		    smooth_inset(hex_r + 4, inner_r_ - 4, smooth_inset,
				 inner_inset=hex_inset);
	       };

	  } else {
	       if(hex_inset) {
		    translate([0, 0, thick - hex_inset]) {
			 linear_extrude(hex_inset + 1) {
			      circle(hex_r + 2, $fn=80);
			 };
		    };
	       };
	  };
	  translate([0, 0, thick - (hex_recess + hex_inset)]) {
	       linear_extrude(hex_recess + hex_inset + 1) {
		    circle(hex_r, $fn=6);
	       };
	  };
     };
}


bolt_knob(11, 4, bolt_r=16.2/2, hex_r=9.2/2, proud=1);


// The end.
