/*
  A filter retainer and cover for my grandfather's roto-tiller, plus
  an optional airbox to go over it.

  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


module cutout_pattern(dims, r=1.5, $fn=6) {
     limit_x = dims.x / 2;
     limit_y = dims.y / 2;

     step = (r * 2) + 1;

     // this isn't the greatest honeycomb I've ever done but it works.

     linear_extrude(dims.z) {
	  intersection() {
	       square([dims.x, dims.y], true);

	       for(xi = [0:limit_x / step]) {
		    for(yi = [0:limit_y / step]) {
			 let(x = (step * xi),
			     y = (step * yi) + (xi % 2) * step / 2) {

			      translate([x, y]) circle(r);
			      translate([x, -y]) circle(r);
			      translate([-x, -y]) circle(r);
			      translate([-x, y]) circle(r);
			 };
		    };
	       };
	  };
     };
}


module filter_plate(thick, $fn=50) {

     outer_dims = [87, 69, thick];

     hole_r = 2.5;
     hole_spacing = 73;
     hole_offset = hole_spacing / 2;

     minkr = 6;
     minkd = minkr * 2;
     minkx = outer_dims.x - minkd;
     minky = outer_dims.y - minkd;

     difference() {
	  linear_extrude(thick) {
	       translate([-minkx / 2, -minky / 2, 0]) {
		    minkowski() {
			 circle(minkr);
			 square([minkx, minky]);
		    };
	       };
	  };

	  translate([hole_offset, 0, -1]) {
	       cylinder(thick + 2, r=hole_r);
	  };

	  translate([-hole_offset, 0, -1]) {
	       cylinder(thick + 2, r=hole_r);
	  };
     };
}


module filter_cover(thick=4, $fn=50) {

     lip = 2;
     lip_thick = 2;

     ridge_dims = [58, 58, thick];

     cutout_dims = [ridge_dims.x - lip,
		    ridge_dims.y - lip,
		    thick + 2];

     difference() {
	  // start from the plate
	  filter_plate(thick);

	  // pop out the honeycomb holes
	  translate([0, 0, -1]) {
	       cutout_pattern(cutout_dims);
	  };

	  // and cut away so that the honeycomb is inset
	  translate([0, 0, (thick / 2) + lip_thick]) {
	       cube(ridge_dims, true);
	  };
     }
}


module filter_airbox(thick=2, $fn=50) {
     box_dims = [62, 69, 20];

     minkr = 6;
     minkd = minkr * 2;
     minkx = box_dims.x - minkd;
     minky = box_dims.y - minkd;

     iminkr = minkr - thick;
     iminkd = iminkr * 2;
     iminkx = box_dims.x - (2 * thick) - iminkd;
     iminky = box_dims.y - (2 * thick) - iminkd;

     inlet_r = (box_dims.z - iminkd) / 2;
     inlet_o = (box_dims.y / 2) - minkd - inlet_r;

     difference() {
	  // start from plate plus airbox exterior
	  union() {
	       filter_plate(thick);
	       translate([-minkx / 2, -minky / 2, 0]) {
		    minkowski() {
			 sphere(minkr);
			 cube([minkx, minky, box_dims.z]);
		    };
	       };
	  };

	  // minus the airbox interior
	  translate([-iminkx / 2, -iminky / 2, 0]) {
	       minkowski() {
		    sphere(iminkr);
		    cube([iminkx, iminky, box_dims.z - thick]);
	       };
	  };

	  // trim off everything below the plate
	  translate([0, 0, -minkr]) {
	       cube([box_dims.x + 1, box_dims.y + 1, minkd], true);
	  };

	  // pop an oblong hole out of the side
	  translate([0, -box_dims.y / 2, (box_dims.z / 2)]) {
	       rotate([90, 0, 0]) {
		    hull() {
			 translate([-inlet_o, 0, 0]) {
			      cylinder(thick + 3, r=inlet_r,
				       center=true);
			 };
			 translate([inlet_o, 0, 0]) {
			      cylinder(thick + 3, r=inlet_r,
				       center=true);
			 };
		    };
	       };
	  };
     };
}


filter_cover();


// The end.
