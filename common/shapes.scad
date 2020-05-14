/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <copies.scad>;


function shared_tangents(p1, p2) =
    let(r1 = p1[2],
        r2 = p2[2],
        dx = p2.x - p1.x,
        dy = p2.y - p1.y,
        d = sqrt(dx * dx + dy * dy),
        theta = atan2(dy, dx) + acos((r1 - r2) / d),
        xa = p1.x +(cos(theta) * r1),
        ya = p1.y +(sin(theta) * r1),
        xb = p2.x +(cos(theta) * r2),
        yb = p2.y +(sin(theta) * r2))
     [ [xa, ya], [xb, yb] ];



module _rounded_polygon(points, $fn=100) {
/*
  each point is [x, y, r] of a circle

  adapted from
  http://forum.openscad.org/Script-to-replicate-hull-and-minkoswki-for-CSG-export-import-into-FreeCAD-td16537.html#a16556
*/

     p_len = len(points);

     function p_tang(index) =
	  shared_tangents(points[index], points[(index + 1) % p_len]);

     // all the positive radius circles
     for(p = points) {
	  if(p[2] > 0) {
	       translate([p.x, p.y]) {
		    circle(p[2]);
	       };
	  };
     };

     difference() {
	  // a polygon connecting the tangent points between all
	  // circles in order
	  polygon([for(i = [0: p_len - 1]) for(e = p_tang(i)) e]);

	  // then subtract all the negative radius circles
	  for(p = points) {
	       if(p[2] < 0) {
		    translate([p.x, p.y]) {
			 circle(-p[2]);
		    };
	       };
	  };
     };
}


module rounded_polygon(points, thick=0, $fn=100) {
     /*
       each point in points is a vector of [x, y, r] where r is
       positive to indicate that it is an interior point, and negative
       to indicate it is an exterior point.
     */

     if(thick) {
	  linear_extrude(thick) {
	       union() {
		    _rounded_polygon(points, $fn);
	       };
	  };
     } else {
	  union() {
	       _rounded_polygon(points, $fn);
	  };
     };
}


function _r_adj(r, adj) =
     let(ra = r + adj) (r > 0)? max(0, ra): ra;


function adj_rounded_poly(points, adj) =
     [for(p=points) [p.x, p.y, _r_adj(p[2], adj)]];


module rounded_inset_poly(points, inset, thick, lip=undef) {
     tl = lip? (thick - lip): (thick / 2);

     rounded_polygon(points, tl);
     translate([0, 0, tl]) {
	  rounded_polygon(adj_rounded_poly(points, -inset),
			  thick - tl);
     };
}


module rounded_outset_poly(points, inset, thick, lip=undef) {
     tl = lip? (thick - lip): (thick / 2);

     rounded_polygon(points, tl);
     rounded_hollow_poly(points, inset, thick);
}


module rounded_hollow_poly(points, inset, thick) {
     linear_extrude(thick) {
	  difference() {
	       rounded_polygon(points);
	       rounded_polygon(adj_rounded_poly(points, -inset));
	  };
     };
}


/**
   A cylinder with a bore through it

   * barrel_r is the exterior radius
   * barrel_h is the overall height
   * bore_r is the interior radius
*/
module barrel(barrel_r, barrel_h, bore_r, $fn=100) {
     linear_extrude(barrel_h) {
	  difference() {
	       circle(barrel_r);
	       circle(bore_r);
	  };
     };
}


/**
   A ring with a circular profile.

   * ring_ir is the interior radius
   * cross_r is the radius of the cross-section
*/
module o_ring(ring_ir, cross_r, $fn=100) {
     rotate_extrude(angle=360) {
	  translate([ring_ir + cross_r, 0, 0]) {
	       circle(cross_r);
	  };
     };
}


/**
   A ring with a D shaped profile.

   * ring_ir is the interior radius
   * cross_r is the radius of the cross-section, before being affected
   by the factor.
   * The factor describes how much of a circle is being presented in
   the cross-section. A factor of 1 is equivalent of an oring.
*/
module d_ring(ring_ir, cross_r, factor=0.25, $fn=100) {

     factor_shift = (cross_r * 2 * factor) - cross_r;

     rotate_extrude(angle=360) {
	  difference() {
	       translate([ring_ir + factor_shift , 0, 0]) {
		    circle(cross_r);
	       };
	       square([ring_ir * 2, ring_ir * 2], true);
	  };
     };
}



module rounded_plate(width, depth, height, turn_r=5.1, $fn=50) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  linear_extrude(height) {
	       minkowski() {
		    square([width - turn_d, depth - turn_d]);
		    circle(turn_r);
	       };
	  };
     };
}


module rounded_box(width, depth, height, turn_r=5, $fn=50) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, turn_r]) {
	  minkowski() {
	       cube([width - turn_d, depth - turn_d, height - turn_d]);
	       sphere(turn_r);
	  };
     };
}


module double_rounded_box(width, depth, height,
			  corner_r, turn_r, $fn=100) {

     corner_d = corner_r * 2;
     turn_d = turn_r * 2;

     hull() {
	  copy_translate(z = height - turn_d) {
	       duplicate([width, depth, 0], [0, 0, 180]) {
		    duplicate([width, 0, 0], [0, 0, 90]) {
			 translate([corner_r, corner_r, turn_r]) {
			      rotate([0, 0, 180]) {
				   rotate_extrude(angle=90, $fn=$fn) {
					translate([corner_r - turn_r, 0]) {
					     circle(turn_r, $fn=$fn/2);
					};
				   };
			      };
			 };
		    };
	       };
	  };
     };
}



// The end.
