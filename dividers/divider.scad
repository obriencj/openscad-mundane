/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/copies.scad>;


module divider(x, y, tall, thick=1, r=5, $fn=100) {
     /*
       an individual divider box, defined by its exterior
       dimensions
     */

     minkx = x - (2 * thick) - (2 * r);
     minky = y - (2 * thick) - (2 * r);
     minko = r + thick;

     difference() {
	  cube([x, y, tall]);

	  translate([minko, minko, minko]) {
	       minkowski() {
		    sphere(r);
		    cube([minkx, minky, tall]);
	       };
	  };
     };
}


module split2_divider(x, y, tall, thick=1, r=5, $fn=100) {
     split_x = (x + thick) / 2;
     offset_x = (x - thick) / 2;

     copy_grid(offsets=[offset_x, 0, 0], grid=[2, 1, 1]) {
	  divider(split_x, y, tall, thick, r);
     };
}


module split4_divider(x, y, tall, thick=1, r=5, $fn=100) {
     split_x = (x + thick) / 2;
     split_y = (y + thick) / 2;

     offset_x = (x - thick) / 2;
     offset_y = (y - thick) / 2;

     copy_grid(offsets=[offset_x, offset_y, 0], grid=[2, 2, 1]) {
	  divider(split_x, split_y, tall, thick, r);
     };
}


module single_divider(xy=100, tall=75) {
     divider(xy, xy, tall);
};


module double_divider(xy=100, tall=75) {
     divider(xy * 2, xy, tall);
};


module quad_divider(xy=100, tall=75) {
     divider(xy * 2, xy * 2, tall);
};


module halved_divider(xy=100, tall=75) {
     split2_divider(xy, xy, tall);
}


module quartered_divider(xy=100, tall=75) {
     split4_divider(xy, xy, tall);
}


module all_dividers(xy=100, tall=75) {
     /*
       All three dividers, layed out such that there's a gap between
       for splitting in the slicer.
     */

     xyo = xy + 10;

     double_divider(xy, tall);
     translate([-xyo, 0, 0]) single_divider(xy, tall);
     translate([0, xyo, 0]) quad_divider(xy, tall);
     translate([-xyo, -xyo, 0]) halved_divider(xy, tall);
     translate([0, -xyo, 0]) quartered_divider(xy, tall);
};


all_dividers();


// The end.
