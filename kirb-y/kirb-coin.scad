/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GNU LGPL v3+
*/


module kirb(r=8) {
     resize([r * 2, 0, 0], auto=true) {
	  import("kirb-face.stl");
     };
}


module kirb_coin(r=18, $fn=50) {

     union() {
	  difference() {
	       // flat cylinder
	       cylinder(4, r=r, $fn=50);

	       // subtract to get an inset (leaving a rim)
	       translate([0, 0, 2]) {
		    cylinder(4, r=r-2, $fn=50);
	       }
	  };

	  // glue the face to it
	  translate([0, -2, 0]) {
	       kirb(r - 6);
	  };
     };
}


module kirb_keychain(r=18, $fn=50) {

     difference() {
	  union() {
	       // take the coin, then...
	       kirb_coin(r, $fn);

	       // add a reinforcing ring, then...
	       translate([0, 15, 0]) {
		    cylinder(4, r=3);
	       };
	  };

	  // poke a hole
	  translate([0, 15, -1]) {
	       cylinder(6, r=2);
	  };
     };
}


kirb_keychain();


// The end.
