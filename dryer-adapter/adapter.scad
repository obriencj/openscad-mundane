


module adapter_grommet(filament_r=1.5) {

     grommet_id = 6.1;
     grommet_thick = 3.5;

     pin_length = grommet_thick;

     pin_or = grommet_id / 2;
     pin_ir = pin_or - 1.5;
     bump_or = pin_or + 0.25;

     $fn = 50;

     difference() {
	  // outer shape of pin, with bump on rim
	  union() {
	       cylinder(pin_length + 1, r=3);
	       translate([0, 0, pin_length]) {
		    cylinder(1, r=bump_or);
	       };
	  }

	  // slots for relief
	  translate([0, 0, 4]) {
	       cube([10, 0.5, 6], center=true);

	       rotate([0, 0, 90]) {
		    cube([10, 0.5, 6], center=true);
	       };
	  };

	  cylinder(pin_length + 1, filament_r, pin_or - 0.75);
     };
}


module adapter_tube(tubing_od=4.1, pinch=0.1, filament_r=1.5) {

     hole_r = tubing_od / 2;
     squeeze_r = hole_r - (pinch / 2);
     spacious_r = hole_r + (pinch / 2);

     $fn = 50;

     difference() {
	  // I like the look of a hex nut for the body of the adapter
	  cylinder(8, r=8, $fn=6);

	  // upper ceiling contracts to the grommet adapter size
	  translate([0, 0, 6.5]) {
	       cylinder(1.5, spacious_r, filament_r);
	  };

	  // main space
	  translate([0, 0, 4]) {
	       cylinder(2.5, r=spacious_r);
	  };

	  // inner flange
	  translate([0, 0, 2]) {
	       cylinder(2, hole_r, squeeze_r);
	  };

	  // bottom flange
	  cylinder(2, spacious_r, squeeze_r);
     };

     // a little ring that fits over the protrusion of the grommet
     translate([0, 0, 8]) {
	  difference() {
	       cylinder(1, r=8);
	       translate([0, 0, -1]) {
		    cylinder(3, r=5.6);
	       };
	  };
     };
}


module adapter(tubing_od=4.1) {
     union() {
	  translate([0, 0, 8]) {
	       adapter_grommet();
	  };
	  adapter_tube(tubing_od);
     };
}


adapter();


// The end.
