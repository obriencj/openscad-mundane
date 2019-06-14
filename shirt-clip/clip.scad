

module loop(loop_r, thick_r) {
     rotate_extrude(angle=360, $fn=100) {
	  translate([loop_r - thick_r, 0, 0]) {
	       circle(thick_r, $fn=50);
	  };
     };
}


module bar(loop_r, thick_r) {
     rotate([0, 90, 0]) {
	  cylinder((loop_r - thick_r) * 2, r=thick_r, center=true, $fn=50);
     };
}


module clip(loop_r, thick_r) {
     loop(loop_r, thick_r);
     bar(loop_r, thick_r);
}


module flat_clip(loop_r, thick_r, z_goof=0) {
     intersection() {
	  translate([0, 0, z_goof]) {
	       clip(loop_r, thick_r);
	  }
	  translate([-loop_r, -loop_r, 0]) {
	       cube([loop_r * 2, loop_r * 2, thick_r + z_goof]);
	  };
     };
}


flat_clip(35, 4, 2);


// The end.
