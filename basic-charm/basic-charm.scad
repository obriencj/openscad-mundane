// Simple charm base design


module CharmStyle1(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };
	       // hanging hole solid
	       translate([0, outer_r, 0]) {
		    cylinder(thick, rim, rim);
	       }
	  };

	  // hanging hole
	  translate([0, outer_r, -1]) {
	       cylinder(thick + 2, rim-1, rim-1);
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0,0,1]) cylinder(thick-1, inner_r, inner_r);
	       children();
	  };
     };
};


module CharmStyle2(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };
	       // hanging hole solid
	       translate([0, outer_r - rim, 0]) {
		    cylinder(thick, rim, rim);
	       }
	  };

	  // hanging hole
	  translate([0, outer_r - rim, -1]) {
	       cylinder(thick + 2, rim-1, rim-1);
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0,0,1]) cylinder(thick-1, inner_r, inner_r);
	       translate([0, -rim/2, 0]) children();
	  };
     };
};


module CharmStyle3(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };
	  };

	  // hanging hole
	  translate([0, outer_r - rim, -1]) {
	       intersection() {
		    translate([0,0,-1]) cylinder(thick+1, inner_r, inner_r);
		    cylinder(thick + 2, rim-1, rim-1);
	       };
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0,0,1]) cylinder(thick-1, inner_r, inner_r);
	       translate([0, -rim/2, 0]) children();
	  };
     };
};


module CharmStyle4(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };
	  };

	  // hanging hole
	  intersection() {
	       translate([0,0,-1]) cylinder(thick+1, inner_r, inner_r);
	       translate([0, outer_r - rim, -1]) {
		    hull() {
			 translate([-rim, 0, 0])
			      cylinder(thick + 2, rim-1, rim-1);

			 translate([rim, 0, 0])
			      cylinder(thick + 2, rim-1, rim-1);
		    };
	       };
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0,0,1]) cylinder(thick-1, inner_r, inner_r);
	       translate([0, -rim/2, 0]) children();
	  };
     };
};


module CharmStyle5(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };

	       translate([0, inner_r, 0])
		    hull() {
		    translate([-rim, 0, 0])
			 cylinder(thick, rim, rim);

		    translate([rim, 0, 0])
			 cylinder(thick, rim, rim);
	       };
	  };

	  // hanging hole
	  translate([0, inner_r, -1]) {
	       hull() {
		    translate([-rim, 0, 0])
			 cylinder(thick + 2, rim-1, rim-1);

		    translate([rim, 0, 0])
			 cylinder(thick + 2, rim-1, rim-1);
	       };
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0,0,1]) cylinder(thick-1, inner_r, inner_r);
	       children();
	  };
     };
};



module CharmStyle6(diameter=20, thick=4, rim=2, $fn=100) {
     outer_r = diameter / 2;
     inner_r = (diameter - rim) / 2;

     // echo(diameter);

     difference() {
	  union() {
	       difference() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, 0, thick - rim]) {
			 cylinder(thick, inner_r, inner_r);
		    };
	       };

	       // hole rim
	       intersection() {
		    cylinder(thick, outer_r, outer_r);
		    translate([0, outer_r - rim, 0])
			 hull() {
			 translate([-rim, 0, 0])
			      cylinder(thick, rim, rim);

			 translate([rim, 0, 0])
			      cylinder(thick, rim, rim);
		    };
	       };
	  };
	  // hanging hole
	  intersection() {
	       translate([0,0,-1]) cylinder(thick+2, inner_r, inner_r);
	       translate([0, outer_r - rim, -1]) {
		    hull() {
			 translate([-rim, 0, 0])
			      cylinder(thick + 2, rim-1, rim-1);

			 translate([rim, 0, 0])
			      cylinder(thick + 2, rim-1, rim-1);
		    };
	       };
	  };
     };

     if ($children) {
	  intersection() {
	       translate([0, 0, 1]) cylinder(thick-1, inner_r, inner_r);
	       translate([0, -rim/2, 0]) children();
	  };
     };
};


module CharmLetters(letters="a", font="", size=12, $fn=100) {

     linear_extrude(height=8) {
	  text(letters, size=size, font=font,
	       halign="center", valign="center");
     };
};


CharmStyle1() {
     CharmLetters(letters="1");
}

translate([25, 0, 0])
CharmStyle2() {
     CharmLetters(letters="2");
}

translate([0, 25, 0])
CharmStyle3() {
     CharmLetters(letters="3");
}

translate([25, 25, 0])
CharmStyle4() {
     CharmLetters(letters="4");
}

translate([0, -25, 0])
CharmStyle5() {
     CharmLetters(letters="5");
}

translate([25, -25])
CharmStyle6() {
     CharmLetters(letters="6");
}



// The end.
