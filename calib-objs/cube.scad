

module both_faces(destv_1, destv_2, mirv) {
     translate(destv_1) children();
     translate(destv_2) mirror(mirv) children();
}


module face_letter(letter, letter_size, letter_inset, $fn=100) {
     thick = letter_inset + 0.5;

     translate([0, 0, -letter_inset])
     resize([letter_size, letter_size, thick]) {
	  linear_extrude(thick)
	       text(letter, size=10,
		    font="Liberation Sans Mono:style=Bold",
		    valign="center", halign="center");
     };
}


module calib_cube(face_size, letter_ratio=0.6) {

     letter_inset = 3;

     letter_size = face_size * letter_ratio;

     p_offs = (face_size / 2);
     n_offs = (-face_size / 2);

     difference() {
	  cube([face_size, face_size, face_size], center=true);

	  both_faces([p_offs, 0, 0], [n_offs, 0, 0], [1, 0, 0]) {
	       rotate([90, 0, 90])
		    face_letter("X", letter_size, letter_inset);
	  };

	  both_faces([0, p_offs, 0], [0, n_offs, 0], [0, 1, 0]) {
	       rotate([90, 0, 180])
		    face_letter("Y", letter_size, letter_inset);
	  };

          both_faces([0, 0, p_offs], [0, 0, n_offs], [0, 0, 1]) {
	       face_letter("Z", letter_size, letter_inset);
	  };
     };
}


calib_cube(25);


// The end.
