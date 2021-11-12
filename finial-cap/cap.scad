/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v.3

  a replacement for a bed-post attachment to allow a smaller finial to
  screw into its place.

  most values here are hard-coded, since it's meant to be used in one
  particular case. If I ever run into a different layout of the same
  idea I might revisit this to make it more parametric.
*/


use <../common/copies.scad>;


module screw_holes(spacing=12, hole_r=2.75, thick=3, $fn=100) {
     // three tapered holes

     union() {
	  copy_rotate(z=120, copies=2) {
	       translate([0, spacing, 2]) {
		    cylinder(3, r=hole_r);
	       };
	       translate([0, spacing, -1]) {
		    cylinder(thick, hole_r + 2.5, hole_r);
	       };
	  };
     };
}


module cross_hole_profile(outer_r=2.5, inner_r=1.00) {
     outer_d = outer_r * 2;
     inner_d = inner_r * 2;

     union() {
	  square([outer_d, inner_d], center=true);
	  square([inner_d, outer_d], center=true);
     };
}


module finial_cap(cross_r=[2.5, 1.0], $fn=100) {

     barrel_r = 12 / 2;
     cap_r = 37 / 2;

     union() {
	  // the wide, thin flat top, with three holes for attaching
	  // to the lower post.
	  difference() {
	       linear_extrude(3) {
		    difference() {
			 circle(cap_r);
			 circle(barrel_r - 1);
		    };
	       };
	       screw_holes();
	  };

	  // the barrel which holds the wood screw of the finial. This
	  // part is recessed into the lower post.
	  linear_extrude(18) {
	       difference() {
		    circle(barrel_r);
		    cross_hole_profile();
	       };
	  };
     };
}


function wood_screw() = [2.5, 1.0];
function quarter_inch() = [6.35 / 2, 4.953 / 2];


// finial_cap(quarter_inch());
finial_cap(wood_screw());


// The end.
