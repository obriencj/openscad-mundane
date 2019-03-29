/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <../common/utils.scad>;
use <keychain.scad>;


simple_keychain(70, 25, 3) {
     translate([0, -1, -0.5]) {
	  words(["CheapJEEP"], size=7, thick=1);
     };
};


// The end.
