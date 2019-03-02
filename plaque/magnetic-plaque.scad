

module rounded_box(width, height, thickness, turn_r=4, $fn=100) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  hull() {
	       cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, 0, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([0, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	  };
     };
}


module subtract_inset_same(width, height, rim, thick, inset) {

     difference() {
	  children();

	  translate([rim, rim, inset]) {
	       resize([width - (2 * rim), height - (2 * rim), thick]) {
		    children();
	       }
	  }
     };
}


module plaque_base(width=30, height=20, rim=1, thick=2, inset=1) {
     turn_r = 1.6;
     turn_d = turn_r * 2;

     difference() {
	  subtract_inset_same(width, height, rim, thick, inset) {
	       render() rounded_box(width, height, thick);
	  };

	  translate([turn_r + 2, turn_r + 2, -1])
	       cylinder(4, turn_r, turn_r);
	  translate([width - turn_r - 2, turn_r + 2, -1])
	       cylinder(4, turn_r, turn_r);
	  translate([width - turn_r - 2, height - turn_r - 2, -1])
	       cylinder(4, turn_r, turn_r);
	  translate([turn_r + 2, height - turn_r - 2, -1])
	       cylinder(4, turn_r, turn_r);
     };
}


module plaque(width=60, height=40, rim=6, thick=4, inset=1, $fn=100) {
     plaque_base(width, height, rim, thick, inset);

     offs = rim + 0.5;
     delt = (2 * rim) - 1;

     if ($children) {
	  translate([offs, offs, thick - inset]) {
	       intersection() {
		    resize([width - delt, height - delt, inset])
			 rounded_box(width, height, inset);

		    children();
	       }
	  }
     }
}


module plaque_title(title, subtitle, $fn=100) {

     // title
     translate([0, 59, 0])
	  linear_extrude(height=5)
	  text(title, size=12, valign="center");

     // subtitle
     translate([0, 45, 0])
	  linear_extrude(height=5)
	  text(subtitle, size=6, valign="center");
}


// The end.
