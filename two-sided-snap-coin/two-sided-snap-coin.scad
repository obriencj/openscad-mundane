

module face(val, $fn=100) {
     union() {
	  cylinder(1, 13.5, 14);
	  linear_extrude(height=2)
	       text(str(val), size=12,
		    halign="center", valign="center");
     };
}

module brim($fn=100) {
     difference() {
	  cylinder(4, 16, 16);
	  translate([0, 0, -1])
	       cylinder(6, 13.95, 13.95);
     }
     translate([0, 0, 1.75]) {
	  difference() {
	       cylinder(0.5, 15, 15);
	       translate([0, 0, -1])
		    cylinder(2, 13.6, 13.6);
	  }
     }
}


module coin(face_1, face_2) {
     translate([-18, 18, 0])
	  face(face_1);

     translate([-18, -18, 0])
	  face(face_2);

     translate([9, 0, 0])
	  brim();
}

coin(5, 23);


// The end.
