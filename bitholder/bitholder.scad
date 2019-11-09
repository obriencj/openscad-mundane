

module _bit_holder(x, y, z, ox, oy, oz) {
     box_dim = (x + y) / 2 ;

     linear_extrude(oz-z) {
	  square([x, y], true);
     };

     difference() {
	  linear_extrude(oz) {
	       difference() {
		    square([ox, oy], true);
		    square([x, y], true);
	       };
	  };
	  translate([0, 0, oz-3]) {
	       rotate([0, 0, 45]) {
		    cylinder(4, box_dim - 3, box_dim, $fn=4);
	       }
	  };
     };
}


module grid(count_x, count_y, spacing) {
     for(col=[0:count_x-1]) {
	  for(row=[0:count_y-1]) {
	       translate([spacing * col, spacing * row]) {
		    children();
	       };
	  };
     };
}


module bit_grid(count_x, count_y, bit_x, bit_y, z, spacing, base) {
     box_dim = (bit_x + bit_y + spacing) / 2;

     // imperceptible overlap to ensure they're a single object
     grid_spacing = box_dim - 0.001;

     grid(count_x, count_y, grid_spacing) {
	  _bit_holder(bit_x, bit_y, z,
		      box_dim, box_dim,
		      z + base);
     };
}


module bit_box(count_x, count_y, bit_x, bit_y, bit_z,
	       bottom_z, top_z,
	       spacing, base) {

     box_dim = (bit_x + bit_y + spacing) / 2;

     bit_grid(count_x, count_y, bit_x, bit_y, bit_z, spacing, base);

     // bottom box
     translate([-box_dim / 2, -box_dim / 2]) {
	  linear_extrude(bottom_z + base) {
	       difference() {
		    minkowski() {
			 circle(2, $fn=50);
			 square([count_x * box_dim, count_y * box_dim]);
		    };

		    // we shrink the subtractive square slightly to
		    // ensure there's overlap with the bit_grid,
		    // preventing them from being treated as separate
		    // objects.
		    square([(count_x * box_dim) - 0.1,
			    (count_y * box_dim) - 0.1]);
	       };
	  };
     };

     lid_slop = 0.2;

     // box lid
     translate([-box_dim / 2, -box_dim * (count_y + 1)]) {
	  difference () {
	       linear_extrude(top_z + base) {
		    minkowski() {
			 circle(2, $fn=50);
			 square([count_x * box_dim, count_y * box_dim]);
		    };
	       };

	       // need some clearance in order to fit smoothly over
	       // the top of the bottom box
	       translate([-lid_slop / 2, -lid_slop / 2, base]) {
		    cube([(count_x * box_dim) + lid_slop,
			  (count_y * box_dim) + lid_slop,
			  top_z + 1]);
	       };
	  };
     };

}


bit_box(2, 2, 6.8, 6.8, 35, 20, 35, 5, 2);
