
use <../common/utils.scad>;


module cover_base(cover_w, cover_h, lip_w, lip_h, thick=3) {
     bottom = 0;

     linear_extrude(thick - 2) {
	  translate([0, bottom]) {
	       square([cover_w, cover_h], true);
	  };
     };

     linear_extrude(thick) {
	  difference() {
	       translate([0, bottom]) {
		    square([cover_w, cover_h], true);
	       };
	       square([lip_w, lip_h], true);
	  };
     };
}


module inlet_cutout(w, h, thick) {
     cube([w, h, thick], true);
}


module filter_cover($fn=50) {

     cover_w = 88;
     cover_h = 67;

     lip_w = 58;
     lip_h = 57;

     hole_offset = (lip_w / 2) + 7;

     thick = 3;

     difference() {
	  cover_base(cover_w, cover_h, lip_w, lip_h, thick);

	  translate([hole_offset, 0, -0.5]) {
	       cylinder(thick + 1, r=2.5);
	  };

	  translate([-hole_offset, 0, -0.5]) {
	       cylinder(thick + 1, r=2.5);
	  };

	  translate([0, 0, -0.5]) {
	       inlet_cutout(lip_w - 2, lip_h - 2, thick + 1);
	  };
     };
}


filter_cover();


// The end.
