/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Some modules for cutting a bore through objects, with optional
  standard english key profiles.
*/


use <../common/units.scad>;
use <../common/utils.scad>;


/*
  [[min diameter in inches, key width in inches], ...]
*/
function _eng_std_keysizes() =
     [[-1/0, 0],
      [5/16, 3/32],
      [1/2, 1/8],
      [5/8, 3/16],
      [15/16, 1/4],
      [21/16, 5/16],
      [23/16, 3/8],
      [29/16, 1/2],
      [37/16, 5/8],
      [45/16, 3/4],
      [53/16, 7/8],
      [61/16, 1],
      [1/0, undef]]; // Inf sentinal value


function _minmax_key_recur(val, index, table) =
     let(curr = table[index],
	 next = table[index + 1])
     ((curr[0] <= val) && (val < next[0]))? curr[1]:
     _minmax_key_recur(val, index + 1, table);


function eng_std_keysize(bore_d_inches) =
     bore_d_inches?
     _minmax_key_recur(bore_d_inches, 0, _eng_std_keysizes()):
     0;


module bore_profile(r, k, keygap=0.25) {
     // The the square key dimension k describes the height and width
     // of the key itself. While the width should match for the bore,
     // the height should have some "wiggle room." That value is the
     // keygap parameter.

     //echo("bore: r=", r, "k=", k);

     circle(r, $fa=1, $fs=1);
     if(k) {
	  translate([0, r + keygap]) {
	       square([k, k], true);
	  };
     };
}


module eng_std_bore_profile(bore_d_inches, keyed=false) {
     r = inch_to_mm(bore_d_inches) / 2;
     k = inch_to_mm(keyed? eng_std_keysize(bore_d_inches): 0);

     bore_profile(r, k);
}


module with_bore(bore_r, key, thick,
		 position=[0, 0, 0], angle=0,
		 overshoot=0.05) {

     2d_cutout(thick, position, overshoot) {
	  union() {
	       children();
	  };
	  rotate([0, 0, angle]) {
	       bore_profile(bore_r, key);
	  };
     };
}


module with_eng_std_bore(bore_d_inches, depth_inches, keyed=false,
			 position=[0, 0, 0], angle=0,
			 overshoot=0.05) {

     2d_cutout(inch_to_mm(depth_inches), position, overshoot) {
	  union() {
	       children();
	  };
	  rotate([0, 0, angle]) {
	       eng_std_bore_profile(bore_d_inches, keyed);
	  };
     };
}


module with_1_2_inch_bore(depth_inches, keyed=false,
			  position=[0, 0, 0], angle=0,
			  overshoot=0.05) {

     with_eng_std_bore(1/2, depth_inches, keyed,
		       position, angle, overshoot) {
	  children();
     };
}


module with_5_8_inch_bore(depth_inches, keyed=false,
			  position=[0, 0, 0], angle=0,
			  overshoot=0.05) {

     with_eng_std_bore(5/8, depth_inches, keyed,
		       position, angle, overshoot) {
	  children();
     };
}


module 5_8_inch_spacer(thick_inches, keyed=true) {
     with_5_8_inch_bore(thick_inches, keyed=keyed, angle=-30) {
	  cylinder(inch_to_mm(thick_inches), r=inch_to_mm(0.75), $fn=6);
     };
}


5_8_inch_spacer(1/4);


// The end.
