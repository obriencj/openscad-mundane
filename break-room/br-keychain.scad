


module feather(width, thick, $fn=100) {
     resize([width, 0, 0], auto=[false, true, false]) {
	  linear_extrude(thick) {
	       import("feather.svg", center=true);
	  };
     };
}


module ring(r, thick, rim, $fn=100) {
     difference() {
	  cylinder(thick, r, r);
	  translate([0, 0, -1]) {
	       cylinder(thick + 2, r - rim, r - rim);
	  };
     };
}


module face(r, thick, inset, rim, $fn=100) {
     difference() {
	  cylinder(thick, r, r);
	  if(inset > 0) {
	       translate([0, 0, thick - inset]) {
		    cylinder(thick, r - rim, r - rim);
	       };
	  };
     };
}


module conjoin_2(height, thickness) {
     union() {
          translate([0, 0, thickness / 2]) {
               children(0);
          };
          translate([0, height, thickness / 2])
          rotate([0, 180, 0]) {
               children(1);
          };
     };
}


module words(txt_v, size=6, thick=5,
             font="Liberation Sans", style="Bold",
             halign="center", valign="center", $fn=100) {

     linear_extrude(height=thick) {
          for(i = [0 : len(txt_v) - 1]) {
               translate([0, i * -(size + 2), 0])
                    text(txt_v[i], size=size,
                         font=str(font, ":style=", style),
                         halign=halign, valign=valign);
          }
     }
}


module break_room_face_1() {
     union() {
	  difference() {
	       face(20, 2, 1.25, 3);

	       translate([0, 0, 1.5]) {
		    ring(19, 3, 1);
	       };
	  };

	  translate([-0.4, 0.5, 0.5]) {
	       feather(32, 1.5);
	  };
     };
}


module break_room_face_2() {
     difference() {
	  face(20, 2, 0, 0);

	  translate([0, 0, 0.5]) {
	       //ring(15.5, 3, 0.5);
	       ring(19, 3, 1);

	       translate([0, 4.25, 0])
		    words(["$34 000", "000 000"],
			  size=6.5, thick=2);
	  };
     };
}


module break_room_keychain() {

     $fn=100;

     difference() {
	  union() {
	       //conjoin_2(0, 3.0) {
	       break_room_face_1();
	       //break_room_face_2();
	       //};

	       translate([0, 17, 0]) {
		    cylinder(2, 3, 3);
	       }
	  }

	  translate([0, 17, 1]) {
	       cylinder(5, 2, 2, center=true);
	  }
     };
}


function odd(x) = (x % 2) == 1;


module repeatedly(r, rows, cols) {
     yr = r - 1;
     xr = r + 1;

     for(y = [0:rows-1]) {
	  translate([odd(y)? r: 0, (2 * yr * y), 0]) {
	       for(x = [0:cols-1]) {
		    translate([(2 * xr * x), 0, 0]) {
			 children();
		    };
	       };
	  };
     };
}


repeatedly(20, 3, 3) {
     render() break_room_keychain();
};


// The end.
