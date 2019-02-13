
module rounded_box(width, height, thickness, turn_r=4, $fn=100) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0])
     hull() {
	  cylinder(thickness, turn_r, turn_r);
	  translate([width - turn_d, 0, 0])
	       cylinder(thickness, turn_r, turn_r);
	  translate([width - turn_d, height - turn_d, 0])
	       cylinder(thickness, turn_r, turn_r);
	  translate([0, height - turn_d, 0])
	       cylinder(thickness, turn_r, turn_r);
     };
}


module plaque_base(width=30, height=20, rim=1, thick=2, inset=1) {

     difference() {
	  rounded_box(width, height, thick);

	  translate([rim, rim, inset])
	       resize([width - (2 * rim),
		       height - (2 * rim),
		       thick])
	       rounded_box(width, height, thick);
     };

};


plaque_base();


// The end.
