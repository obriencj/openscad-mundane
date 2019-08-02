

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


module conjoin(height, thickness) {
     union() {
          translate([0, 0, thickness / 2]) {
               children();
          };
          translate([0, height, thickness / 2])
          rotate([0, 180, 0]) {
               children();
          };
     };
}

module circletext(mytext, textsize=20,
		  radius=100, thickness=3,
		  degrees=360, top=true){

     //myfont="Liberation Mono Sans:style=Bold";
     myfont="Fakt Slab Stencil Pro:style=Bold";

     chars = len(mytext);

     cc = chars + 1;
     dcc = (degrees / cc);

     step = top? 1: -1;
     ts = top? 0: textsize / 2;
     d2 = (degrees / 2) - dcc;

     linear_extrude(thickness) {
	  for (i = [0:chars-1]) {
	       rotate([0, 0, step * (d2 - i * dcc)])
		    translate([0, step * radius - ts, 0])
		    text(mytext[i],
			 halign="center",
			 font=myfont, size=textsize);
	  };
     };
}


module four_times(r) {
     children();

     rotate([0, 0, 90]) {
	  children();
     };

     rotate([0, 0, 180]) {
	  children();
     };

     rotate([0, 0, 270]) {
	  children();
     };
}


module break_room_face() {
     difference() {
	  face(20, 1.5, 0.0, 2);

	  translate([0, 0, 0.5]) {
	       ring(15.5, 3, 0.25);
	       ring(19.5, 3, 0.25);

	       four_times(16.5) {
		    render() {
			 circletext("$ 34 Billion",
				    radius=16.25,
				    textsize=2.5, degrees=80, top=true);
		    };
	       };
	  };

	  translate([-0.4, 0, 0.5]) {
	       feather(28, 2);
	  };
     };
}


conjoin(0, 3.0) {
     break_room_face();
};




// The end.
