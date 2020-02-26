/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


// Single Box X and Y Dimension
BOX_XY = 100;      // [50:200]

// Box Height
BOX_Z = 75;        // [20:100]

// Box Wall Thickness
WALL_THICK = 1;     // [1:4]

FILLET_RADIUS = 5;  // [2:10]


module copy_translate(x=0, y=0, z=0, copies=1) {
     if(copies) {
          for(i = [0:copies]) {
               translate([x * i, y * i, z * i]) {
                    children();
               };
          };
     } else {
          children();
     }
}


module copy_grid(offsets=[0, 0, 0], grid=[1, 1, 1]) {
     copy_translate(x=offsets.x, copies=grid.x-1) {
          copy_translate(y=offsets.y, copies=grid.y-1) {
               copy_translate(z=offsets.z, copies=grid.z-1) {
                    children();
               };
          };
     };
}


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


module single_divider(xy=100, tall=75, thick=1, r=5) {
     divider(xy, xy, tall, thick, r);
};


module double_divider(xy=100, tall=75, thick=1, r=5) {
     divider(xy * 2, xy, tall, thick, r);
};


module quad_divider(xy=100, tall=75, thick=1, r=5) {
     divider(xy * 2, xy * 2, tall, thick, r);
};


module halved_divider(xy=100, tall=75, thick=1, r=5) {
     split2_divider(xy, xy, tall, thick, r);
}


module quartered_divider(xy=100, tall=75, thick=1, r=5) {
     split4_divider(xy, xy, tall, thick, r);
}


module all_dividers(xy=100, tall=75, thick=1, r=5) {
     /*
       All three dividers, layed out such that there's a gap between
       for splitting in the slicer.
     */

     xyo = xy + 10;

     double_divider(xy, tall, thick, r);
     translate([-xyo, 0, 0]) single_divider(xy, tall, thick, r);
     translate([0, xyo, 0]) quad_divider(xy, tall, thick, r);
     translate([-xyo, -xyo, 0]) halved_divider(xy, tall, thick, r);
     translate([0, -xyo, 0]) quartered_divider(xy, tall, thick, r);
};


all_dividers(xy=BOX_XY, tall=BOX_Z, thick=WALL_THICK, r=FILLET_RADIUS);


// The end.
