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


//
// mill_round chamfers the edges off its polygon children in order to
// produce a rounded polygon, as if milled rather than turned.
//
// contributed by @vathpela
//
module mill_round(bounds=[10, 10], radius=1, $fn=200)
{
    d = bounds[0];
    w = bounds[1];
    r = radius;

    offset(r=r, chamfer=true)
        offset(r=-r, chamfer=true)
            children();
}


//
// milled_round_square builds a square of size specified by
//
//   size=[x,y]
//
// with a corner radius specified by
//
//   radius=r
//
// contributed by @vathpela
//
module milled_round_square(size=[10, 10], radius=1, $fn=200)
{
    mill_round(bounds=size, radius=radius, $fn=$fn)
        square(size);
}

//
// mill_round_3d() rounds the edges of its children in three demensions, as
// if by three passes of a mill, rather than turned on a lathe.
//
// It accomplishes this by cutting polygons in the [+x,+y,+z] space
// described by its 3 polygon children:
//
//   xy polygon
//   xz polygon
//   yz polygon
//
// bounds=[width, depth, height] describe the maximum distances on which to
// apply the offset, because scad can't reasonably deal with infinities or
// tell me where child objects *are*, even in coordinates from a relative
// origin.
//
// corner radiuses are specified by radii=[xr, yr, zr]
//
// note that the rounding is done using negative offset radii.
//
// the child polygons must be placed in the following planes and bounds:
//
//   [+x,+y] bounded by [0, 0] and bounds[0:1]
//   [+y,+z] bounded by [0, 0] and bounds[0:2]
//   [+y,+z] bounded by [0, 0] and bounds[1:2]
//
// contributed by @vathpela
//
module mill_round_3d(bounds=[10, 10, 10], radii=[1, 1, 1], $fn=200)
{
    w = bounds[0];
    d = bounds[1];
    h = bounds[2];
    rx = radii[0];
    ry = radii[1];
    rz = radii[2];

    intersection()
    {
        linear_extrude(height=h)
            offset(r=ry, chamfer=true)
                offset(r=-ry, chamfer=true)
                    children(0);
        rotate([-90, -90, 0])
            linear_extrude(height=w)
                offset(r=rz, chamfer=true)
                    offset(r=-rz, chamfer=true)
                        children(1);
        rotate([0, 90, 0])
            linear_extrude(height=d)
                offset(r=rx, chamfer=true)
                    offset(r=-rx, chamfer=true)
                        children(2);
    }
}

//
// milled_round_box draws a box with edges rounded as if by three passes
// with a mill, rather than as if turned on a lathe.  The box is desciribed
// by:
//
//   size[width-in-x, depth-in-y, height-in-z]
//
// with corner radii carved out at thicknesses described by:
//
//   radii[xz, yz, xy]
//
// where xz/yz/xy describe the point of view the box is being observed from
//
// contributed by @vathpela
//
module milled_round_box(size=[10, 10, 10], radii=[1, 1, 1], $fn=200)
{
    w = size[0];
    d = size[1];
    h = size[2];

    mill_round_3d(bounds=size, radii=radii)
    {
        polygon([[0, 0], [w, 0], [w, d], [0, d]]);
        polygon([[0, 0], [0, w], [h, w], [h, 0]]);
        polygon([[0, 0], [0, d], [-h, d], [-h, 0]]);
    }
}


// The end.
