/*
  author: Christopher O'Brien <obriencj@gmail.com>
  license: GPL v3
*/


use <magnetic-retainer-box.scad>;


module inwords(label, depth=1) {

     translate([0, 0, -1]) {
	  linear_extrude(depth + 1) {
	       rotate([180, 0, 0]) {
		    text(label,
			 font="Liberation Sans:style=Bold",
			 size=9, valign="center", halign="center");
	       };
	  };
     };
}


module zoe_retainer() {

     // dimensions specific to Zoe's retainer. The retainer_box module
     // accepts its parameters as interior dimensions, so it will be
     // slightly larger than these dimensions inside.
     i_width = 66;
     i_depth = 48;
     i_height = 12;

     // how sturdy I want the box to be. This pads out the interior
     // dimensions to become the exterior dimensions
     wall_thick = 1.5;

     text_inset = 0.5;

     difference() {
	  retainer_box(i_width, i_depth, i_height,
		       wall_thick=2.0, magnet_spacing=16);

	  // I asked Zoe if she wanted it to have text, and she
	  // responded "something like beep boop" So we'll inset that
	  // text onto the two case halves.

	  translate([0, i_depth / 2, 0]) {
	       inwords("Beep", text_inset);
	  };

	  rotate([0, 0, 180]) {
	       translate([0, i_depth / 2, 0]) {
		    inwords("Boop", text_inset);
	       };
	  };
     };
}


zoe_retainer();


// The end.
