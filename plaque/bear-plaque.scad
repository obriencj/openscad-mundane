/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;
use <magnetic-plaque.scad>;


difference() {
     plaque(width=100, height=50, rim=5, thick=4, inset=1.5) {

	  // title
	  translate([0, 7, 0])
	       words(["Bear"], size=18);

	  // subtitle
	  translate([0, -9, 0])
	       words(["Keep your hands off of",
		      "my tools, you goobers"],
		     size=4,
		     style="Bold Italic");
     };

     translate([50, 2.25, 3.5]) {
	  words(["Littlebear O'Brien    est. 1986"],
		size=3.25, style="Bold");
     };

     translate([50, 47.25, 3.5]) {
	  words(["these tools ain't fo' fools"],
		size=3.25, style="Bold");
     };
};



// The end.
