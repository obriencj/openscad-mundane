

use <keychain.scad>;


simple_keychain(70, 25, 3) {
     translate([38, 12, 1]) {
	  linear_extrude(1) {
	       text("CheapJEEP", font="Liberation Sans:style=Bold",
		    size=7, valign="center", halign="center");
	  };
     };
};


// The end.
