

use <../common/copies.scad>;
use <../common/shapes.scad>;


function _shelf_profile_points() =
     [[0, 0, 0],
      [0, 2, 0],
      [2, 4, -2],
      [20, 30, -1],
      [20, 32, 1],
      [23, 30, 2],
      [21, 8, -6],
      [22, 1, 1],
      [22, 0, 0]];


function _shelf_boundary_points() =
     [[0, 0, 0],
      [0, 2, 0],
      [20, 32, 1],
      [23, 30, 2],
      [2, 0, 0]];


module _single_shelf(wide, male=true, female=true, $fn=50) {
     pin_r = 2;
     pin = [10, 5];

     // note that the pin and hole will be 1mm shorter, due to
     // intentional overlap with the shelf body
     pin_l = 4;

     // wider hole, shorter pin
     slop = 0.1;

     difference() {
	  union() {
	       rounded_polygon(_shelf_profile_points(), thick=wide);
	       rounded_polygon(_shelf_boundary_points(), thick=1);
	  };
	  if(female) {
	       translate([pin.x, pin.y, -1]) {
		    // make the holes slightly wider
		    cylinder(r=pin_r + slop, pin_l);
	       };
	  };
     }

     if(male) {
	  translate([pin.x, pin.y, wide - 1]) {
	       // make the pins slightly shorter
	       cylinder(r=pin_r, pin_l - slop);
	  };
     };
}


module hotwheels_shelf(wide=90, rows=5, tall=40, $fn=50) {

     // the shelf profiles
     copy_translate(x=tall, copies=rows-1) {
	  _single_shelf(wide);
     };

     // the backing plate that joins the shelves together
     linear_extrude(wide) {
	  hull() {
	       translate([0, 1]) {
		    circle(1);
	       };
	       translate([tall * (rows - 1), 1]) {
		    circle(1);
	       };
	  };

     };
}


module hotwheels_left_end(rows=5, tall=40, $fn=50) {
     pin_r = 2;
     pin = [10, 5];

     // note that the pin and hole will be 1mm shorter, due to
     // intentional overlap with the shelf body
     pin_l = 4;

     // wider hole, shorter pin
     slop = 0.1;

     backplate_bottom = tall * (rows - 1) + 22;

     difference() {
	  union() {
	       // the left end needs the profile of the shelf
	       // boundary, but not a real shelf
	       copy_translate(x=tall, copies=rows-1) {
		    union() {
			 rounded_polygon(_shelf_profile_points(), thick=1);
			 rounded_polygon(_shelf_boundary_points(), thick=1);
		    };
	       };

	       // the backing plate that joins the shelves together
	       linear_extrude(19) {
		    hull() {
			 translate([0, 1]) {
			      circle(1);
			 };
			 translate([0, 7]) {
			      circle(3);
			 };
			 translate([backplate_bottom, 1]) {
			      circle(1);
			 };
			 translate([backplate_bottom, 7]) {
			      circle(3);
			 };
		    };
	       };
	  };

	  copy_translate(x=tall, copies=rows-1) {
	       translate([pin.x, pin.y, -1]) {
		    // make the holes slightly wider
		    cylinder(r=pin_r + slop, pin_l);
	       };
	  };

	  translate([15, -1, 3]) {
	       cube([28, 7, 14]);
	  };
     };
}


module hotwheels_right_end(rows=5, tall=40, $fn=50) {
     pin_r = 2;
     pin = [10, 5];

     // note that the pin and hole will be 1mm shorter, due to
     // intentional overlap with the shelf body
     pin_l = 4;

     // wider hole, shorter pin
     slop = 0.1;

     backplate_bottom = tall * (rows - 1) + 22;

     wide = 18;

     difference() {
	  // the backing plate that joins the shelves together
	  linear_extrude(wide) {
	       hull() {
		    translate([0, 1]) {
			 circle(1);
		    };
		    translate([0, 7]) {
			 circle(3);
		    };
		    translate([backplate_bottom, 1]) {
			 circle(1);
		    };
		    translate([backplate_bottom, 7]) {
			 circle(3);
		    };
	       };
	  };

	  translate([15, -1, 2]) {
	       cube([28, 7, 14]);
	  };
     };

     copy_translate(x=tall, copies=rows-1) {
	  translate([pin.x, pin.y, wide - 1]) {
	       // make the pins slightly shorter
	       cylinder(r=pin_r, pin_l - slop);
	  };
     };
}


hotwheels_shelf(rows=5);


// The end.
