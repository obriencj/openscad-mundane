

module face(diameter, thickness, $fn=100) {
     union() {
	  cylinder(thickness / 2, (diameter - thickness) / 2, diameter / 2);
	  children();
     };
}


module text_face(txt, diameter, thickness, fontsize, $fn=100) {
     face(diameter, thickness) {
	  linear_extrude(height=thickness)
	       text(str(val), size=fontsize,
		    halign="center", valign="center");
     };
}


module brim(diameter, thickness, rim, $fn=100) {

     wiggle = 0.5;

     idiam = diameter - rim;
     irad = idiam / 2;

     hthick = thickness / 2;
     qthick = thickness / 4;

     iid = (idiam - hthick) - wiggle;
     iir = (iid / 2);

     difference() {
	  union() {
	       difference() {
		    cylinder(thickness, diameter / 2, diameter / 2);
		    translate([0, 0, -1])
			 cylinder(thickness + 2, irad, irad);

 	       };
	       translate([0, 0, qthick + 0.25])
		    cylinder(hthick - 0.5, irad, irad);
	  };

	  // just to clean up the hole slightly
	  translate([0, 0, qthick])
	       cylinder(hthick, iir, iir);

	  // upper bevel
	  translate([0, 0, hthick])
	       cylinder(qthick, iir, (irad + qthick) + wiggle);

	  // lower bevel
	  translate([0, 0, qthick])
	       cylinder(qthick, (irad + qthick) + wiggle, iir);
     };
}


module text_coin(face_1, face_2,
		 diameter=16, thickness=4, rim=2,
		 fontsize=12) {

     placement = diameter + 2;

     brim(diameter, thickness, rim);

     translate([-placement, 0, 0])
	  text_face(face_1, diameter - rim, thickness / 2, fontsize);

     translate([-placement, -placement, 0])
	  text_face(face_2, diameter - rim, thickness / 2, fontsize);
}


module coin(diameter=16, thickness=4, rim=2) {

     placement = diameter + 2;

     brim(diameter, thickness, rim);

     translate([-placement, 0, 0]) {
	  face(diameter - rim, thickness / 2) {
	       translate([0, 0, thickness / 4])
		    children(0);
	  };
     };

     translate([-placement, -placement, 0]) {
	  face(diameter - rim, thickness / 2) {
	       translate([0, 0, thickness / 4])
		    children(1);
	  };
     };
}


// The end.
