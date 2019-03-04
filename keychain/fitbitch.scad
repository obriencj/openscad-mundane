

use <keychain.scad>;


simple_keychain(50, 20, 3) {
     translate([28, 10, 1]) {
	  linear_extrude(1) {
	       text("#fitbitch", font="Liberation Sans:style=Bold",
		    size=7, valign="center", halign="center");
	  };
     };
};


// The end.
