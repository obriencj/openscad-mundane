

module cutout_pattern(dims, $fn=6) {
     limit_x = dims.x / 2;
     limit_y = dims.y / 2;

     r = 1.5;
     step = (r * 2) + 1;

     linear_extrude(dims.z) {
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
}


module filter_cover($fn=50) {

     hole_r = 2.5;
     hole_spacing = 73;
     hole_offset = hole_spacing / 2;

     thick = 4;

     lip = 2;
     lip_thick = 2;

     outer_dims = [87, 67, thick];

     ridge_dims = [58, 58, thick];

     cutout_dims = [ridge_dims.x - lip,
		    ridge_dims.y - lip,
		    thick + 2];

     difference() {
	  translate([0, 0, thick / 2]) {
	       cube(outer_dims, true);
	  };

	  intersection() {
	       translate([0, 0, thick / 2]) {
		    cube(cutout_dims, true);
	       };
	       translate([0, 0, -1]) {
		    cutout_pattern(cutout_dims);
	       };
	  };

	  translate([0, 0, (thick / 2) + lip_thick]) {
	       cube(ridge_dims, true);
	  };

	  translate([hole_offset, 0, -1]) {
	       cylinder(thick + 2, r=hole_r);
	  };

	  translate([-hole_offset, 0, -1]) {
	       cylinder(thick + 2, r=hole_r);
	  };
     }
}


filter_cover();


// The end.
