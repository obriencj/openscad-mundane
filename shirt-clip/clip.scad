/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module loop(loop_r, thick_r) {

     // start with a circle offset from the origin point, then extrude
     // it in a loop.

     rotate_extrude(angle=360, $fn=100) {
	  translate([loop_r - thick_r, 0, 0]) {
	       circle(thick_r, $fn=50);
	  };
     };
}


module bar(loop_r, thick_r) {

     // the diameter of the loop, minus the diameter of the solid
     // itself.
     width = (loop_r - thick_r) * 2;

     rotate([0, 90, 0]) {
	  cylinder(width, r=thick_r, center=true, $fn=50);
     };
}


module clip(loop_r, thick_r) {

     // just stick the bar and the loop together, easy enough.

     loop(loop_r, thick_r);
     bar(loop_r, thick_r);
}


module flat_clip(loop_r, thick_r, z_goof=0) {

     // the z_goof is a value in mm for how far past the center of the
     // clip we should go before flattening it out. A value of 0 would
     // make the clip effectively be chopped in half.

     intersection() {

	  // move the clip up to save the z_goof amount
	  translate([0, 0, z_goof]) {
	       clip(loop_r, thick_r);
	  }

	  // only keep what's within the cube
	  translate([-loop_r, -loop_r, 0]) {
	       cube([loop_r * 2, loop_r * 2, thick_r + z_goof]);
	  };
     };
}


// these dimensions work pretty well for keeping a tshirt clipped up.
flat_clip(35, 4, 2);


// The end.
