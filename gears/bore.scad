/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Some modules for cutting a bore through objects, with optional
  standard english key profiles.
*/



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


function inch_to_mm(x) = x * 25.4;
function vec_inch_to_mm(v) = [for(x=v) inch_to_mm(x)];

function mm_to_inch(x) = x / 25.4;


module _2d_cutout(thick, position, overshoot=0.05) {

     // overshoot is used to prevent weird z-clipping artifacts, it
     // ensures that the subtracted shape is slightly thicker than the
     // solid body and passes both faces fully. If the cutout is not
     // meant to go all the way through, set overshoot to 0 and
     // overstate the thickness by some amount.

     oz = thick + (overshoot * 2);
     op = [position.x, position.y, position.z - overshoot];

     difference() {
	  children(0);
	  translate(op) {
	       linear_extrude(oz) {
		    children(1);
	       };
	  };
     };
}


module _bore(r, k, keygap=0.25) {
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


module with_bore(bore_r, key, thick,
		 position=[0, 0, 0], angle=0,
		 overshoot=0.05) {

     _2d_cutout(thick, position, overshoot) {
	  union() {
	       children();
	  };
	  rotate([0, 0, angle]) {
	       _bore(bore_r, key);
	  };
     };
}


module with_eng_std_bore(bore_d_inches, depth_inches, keyed=false,
			 position=[0, 0, 0], angle=0,
			 overshoot=0.05) {

     r = inch_to_mm(bore_d_inches) / 2;
     k = inch_to_mm(keyed? eng_std_keysize(bore_d_inches): 0);
     z = inch_to_mm(depth_inches);
     with_bore(r, k, z, position, angle, overshoot) {
	  children();
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


module eng_cube(eng_dimensions, center=false) {
     cube(vec_inch_to_mm(eng_dimensions), center=center);
}


module 5_8_inch_square_spacer(thick_inches, keyed=true) {

     // since the eng_cube will be centered, we need to shift the
     // starting position of the bore downwards by half that amount.
     pos = vec_inch_to_mm([0, 0, -thick_inches / 2]);

     with_5_8_inch_bore(thick_inches, keyed=keyed, position=pos, angle=45) {
	  eng_cube([1, 1, thick_inches], true);
     };
}


/* a 1" x 1" x 1/4" spacer with a 5/8" keyed bore */
5_8_inch_square_spacer(1/4);


// The end.
