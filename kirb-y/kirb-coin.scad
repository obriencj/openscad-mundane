

module kirb(dia=8) {
     resize([dia * 2, 0, 0], auto=true) {
	  import("kirb-face.stl");
     };
}


module kirb_coin(dia=18, $fn=50) {

     union() {
	  difference() {
	       cylinder(4, dia, dia, $fn=50);
	       translate([0, 0, 2])
		    cylinder(4, dia-2, dia-2, $fn=50);
	  };
	  translate([0, -2, 0])
	       kirb(dia - 6);
     }
}


module kirb_keychain(dia=18, $fn=50) {

     difference() {
	  union() {
	       kirb_coin(dia, $fn);
	       translate([0, 15, 0])
		    cylinder(4, 3, 3);
	  };

	  translate([0, 15, -1])
	       cylinder(6, 2, 2);
     };
}


kirb_keychain();


// The end.
