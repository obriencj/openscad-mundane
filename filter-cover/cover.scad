
use <../common/utils.scad>;


module cover_base(cover_w, cover_h, lip_w, lip_h, thick=3) {
     linear_extrude(thick - 2) {
	  translate([0, (cover_h - lip_h - 2) / 2]) {
	       square([cover_w, cover_h + 2], true);
	  };
     };

     linear_extrude(thick) {
	  difference() {
	       translate([0, (cover_h - lip_h - 2) / 2]) {
		    square([cover_w, cover_h + 2], true);
	       };
	       square([lip_w, lip_h], true);
	  };
     };
}


module inlet_cutout(w, h, thick) {
     cube([w, h, thick], true);
}


module filter_cover($fn=50) {

     cover_w = 89;
     cover_h = 66.675;

     lip_w = 60;
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
