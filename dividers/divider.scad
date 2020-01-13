

module divider(x, y, tall, thick=1, r=5, $fn=100) {

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


module single_divider(xy=100, tall=75) {
     divider(xy, xy, tall);
};


module double_divider(xy=100, tall=75) {
     divider(xy * 2, xy, tall);
};


module quad_divider(xy=100, tall=75) {
     divider(xy * 2, xy * 2, tall);
};


module all_dividers(xy=100, tall=75) {
     /*
       All three dividers, layed out such that there's a 10mm gap
       between.
      */

     xyo = xy + 10;

     double_divider(xy, tall);
     translate([-xyo, 0, 0]) single_divider(xy, tall);
     translate([0, xyo, 0]) quad_divider(xy, tall);
};


all_dividers();


// The end.
