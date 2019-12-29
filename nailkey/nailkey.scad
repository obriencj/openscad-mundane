/*
  Simple nail key (for hanging things on the wall from a nail)

  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/



/**
   subtracts a nailkey from child object (as a union)
 */
module with_nailkey(pos=[0, 0, 0], rot=[0, 0, 0]) {
     difference() {
	  union() {
	       children();
	  };

	  translate(pos) {
	       rotate(rot) {
		    nailkey();
	       };
	  };
     };
}


/**
   the inverse shape for a nailkey. Subtract this shape to make a hole
   appropriate for slotting a nail head for wall mounting.
 */
module nailkey($fn=50) {
     thick = 2;

     nail_head = 12;
     nail_shaft = 4;

     nail_head_r = nail_head / 2;
     nail_shaft_r = nail_shaft / 2;

     linear_extrude(thick) {
	  hull() {
	       translate([-nail_head_r, 0]) {
		    circle(nail_head_r);
	       };
	       translate([nail_head_r, 0]) {
		    circle(nail_head_r);
	       };
	  };
     };

     // we want to ensure it pokes a hole through things, so make this
     // protrosion extra long
     linear_extrude(thick + 10) {
	  hull() {
	       translate([-nail_head_r, 0]) {
		    circle(nail_shaft_r);
	       };
	       translate([nail_head_r, 0]) {
		    circle(nail_shaft_r);
	       };
	  };
	  translate([nail_head_r, 0]) {
	       circle(nail_head_r);
	  };
     };
}


// demo piece, printed face-down. Very useful for gluing into objects,
// just leave a 30 x 18 space and then glue this block into it.
with_nailkey(rot=[180, 0, 0], pos=[0, 0, 1]) {
     cube([30, 18, 6], true);
}


// The end.
