/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;
use <magnetic-plaque.scad>;


plaque(width=100, height=50, rim=5, thick=4, inset=2) {

     // title
     translate([0, 5, 0]) {
	  words(["Zoe O'Brien"], size=11);
     };

     // subtitle
     translate([0, -8, 0]) {
	  words(["~ owo uwu owo ~"], size=6,
		style="Bold Italic");
     };
}


// The end.
