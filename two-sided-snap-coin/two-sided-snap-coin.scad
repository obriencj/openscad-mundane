

module face(val, diameter, thickness, fontsize, $fn=100) {
     union() {
	  cylinder(thickness / 2, (diameter - thickness) / 2, diameter / 2);
	  linear_extrude(height=thickness)
	       text(str(val), size=fontsize,
		    halign="center", valign="center");
     };
}

module brim(diameter, thickness, rim, $fn=100) {
     idiam = diameter - rim;

     hthick = thickness / 2;
     qthick = thickness / 4;

     iid = (idiam - hthick);
     iir = iid / 2;

     wiggle = 0.1;

     difference() {
	  union() {
	       difference() {
		    cylinder(thickness, diameter / 2, diameter / 2);
		    translate([0, 0, -1])
			 cylinder(thickness + 2, idiam / 2, idiam / 2);

 	       };
	       translate([0, 0, qthick + 0.25])
		    cylinder(hthick - 0.5, idiam / 2, idiam / 2);
	  };

	  // just to clean up the hole slightly
	  translate([0, 0, qthick])
	       cylinder(hthick, iir - wiggle, iir - wiggle);

	  // upper bevel
	  translate([0, 0, qthick * 2])
	       cylinder(qthick, iir, (idiam / 2) + wiggle);

	  // lower bevel
	  translate([0, 0, qthick])
	       cylinder(qthick, (idiam / 2) + wiggle, iir);
     };
}


module coin(face_1, face_2,
	    diameter=16, thickness=4, rim=2,
	    fontsize=12) {

     placement = diameter + 2;

     brim(diameter, thickness, rim);

     translate([-placement, 0, 0])
	  face(face_1, diameter - rim, thickness / 2, fontsize);

     translate([-placement, -placement, 0])
	  face(face_2, diameter - rim, thickness / 2, fontsize);
}


// The end.
