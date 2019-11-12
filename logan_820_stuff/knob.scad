

use <../common/copies.scad>;
use <../common/shapes.scad>;


function rotate_point(p, angle, c=[0, 0]) =
     [cos(angle) * (p.x - c.x) - sin(angle) * (p.y - c.y) + c.x,
      sin(angle) * (p.x - c.x) + cos(angle) * (p.y - c.y) + c.y,
      p[2]];


function knob_points(r1=20, r2=16, c=6, steps=6) =
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


module bolt_knob(thick=10, recess=4, bolt_r=3.1, hex_r=5.8, proud=2) {
     difference() {
	  rounded_outset_poly(knob_points(), 3, thick, recess);
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


bolt_knob(7, 3, proud=2);


// The end.
