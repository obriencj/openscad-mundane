

use <../common/copies.scad>;
use <../common/shapes.scad>;
use <../common/utils.scad>;
use <../gears/gears.scad>;
use <../hinges/unpinned.scad>;

use <change_gears.scad>;


function gear_points() =
     let(modul = default_modul(),
	 i73_r = root_radius(modul, 73) + (2 * modul),
	 g48_r = root_radius(modul, 48) + (2 * modul),
	 g24_r = root_radius(modul, 24) + (2 * modul))
     [[i73_r, i73_r, i73_r],
      [145, g48_r, g48_r],
      [119, (i73_r * 2) - g24_r, g24_r]];


module gear_plate(plate_thick, ring_thick, $fn=100) {
     points = gear_points();

     bore = default_bore_mm();
     bore_r = bore / 2;

     cone_up = plate_thick + ring_thick;
     cone_tall = default_thick_mm() / 2;

     magnet_r = 2;
     magnet_h = 4; // doubled up

     for(p = points) {
	  translate([p.x, p.y,cone_up]) {
	       difference() {
		    cylinder(cone_tall, bore_r, bore_r / 2);
		    translate([0, 0, cone_tall - magnet_h]) {
			 cylinder(r=magnet_r + 0.1, magnet_h + 1);
		    };
	       };
	  };
     };

     for(p = points) {
	  translate([p.x, p.y, plate_thick]) {
	       cylinder(ring_thick, r=bore_r + 5);
	  };
     };

     p0 = points[0];
     p1 = points[1];
     rounded_plate((p1.x + p1[2]), 2 * p0[2], plate_thick, p1[2], $fn=200);
}


module gear_half_box(wall_thick=1.5, $fn=100) {

     ring_thick = 0.5;

     points = gear_points();
     p0 = points[0];
     p1 = points[1];

     corner_r = p1[2];
     turn_r = 2;

     corner_d = 2 * corner_r;
     turn_d = 2 * turn_r;

     width = (p1.x + p1[2]) + turn_d;
     depth = (2 * p0[2]) + turn_d;
     height = (default_thick_mm() / 2) + ring_thick;

     difference() {
	  rounded_plate(width + (2 * wall_thick),
			depth + (2 * wall_thick),
			height + wall_thick,
			corner_r + wall_thick, $fn=100);

	  translate([wall_thick, wall_thick, wall_thick]) {
	       double_rounded_box(width, depth, height + wall_thick,
				  corner_r, turn_r, $fn=100);
	  };
     };

     translate([turn_r + wall_thick, turn_r + wall_thick, 0]) {
	  gear_plate(wall_thick, ring_thick);
     };
}


module gear_box(wall_thick=1.5) {

     ring_thick = 0.5;

     points = gear_points();
     p0 = points[0];
     p1 = points[1];

     corner_r = p1[2];
     turn_r = 2;

     corner_d = 2 * corner_r;
     turn_d = 2 * turn_r;

     width = (p1.x + p1[2]) + turn_d;
     depth = (2 * p0[2]) + turn_d;
     height = (default_thick_mm() / 2) + ring_thick;

     hinge_barrel_width = 6;
     hinge_gap = 2;
     hinge_count = 8;

     copy_mirror([0, 1, 0]) {
	  rotate([0, 0, 180]) {
	       translate([-width / 2, hinge_gap, 0]) {
		    gear_half_box();
	       };
	  };
     };

     unpinned_hinges(hinge_barrel_width, height + wall_thick + 0.1,
		     hinge_gap, hinge_count, pin_r=0.45);
}


module cutout_words(inset=0.5) {
     translate([0, 0, -1]) {
	  linear_extrude(inset + 1) {
	       rotate([180, 0, 0]) {
		    children();
	       };
	  };
     };
}


module tubalcain_gear_box() {

     text_inset = 0.5;

     difference() {
	  gear_box();
	  cutout_words(text_inset) {
	       translate([0, -25]) {
		    2d_words(["Herringbone Change Gears",
			      "24 stud, 73 idler, 48 screw"], size=8);
	       };
	       translate([0, -65]) {
		    2d_words(["Logan 820 Lathe"], size=12);
	       };
	       translate([0, -95]) {
                    2d_words(["for Mr. Lyle \"tubalcain\" Peterson",
			      "April, 2020"]);
	       };
	  };
     };
}


tubalcain_gear_box();


// The end.
