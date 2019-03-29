/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;
use <keychain.scad>;


simple_keychain(50, 20, 3) {
     translate([0, 0, -0.5]) {
	  words(["#fitbitch"], size=7, thick=1);
     };
};


// The end.
