

// 18, 35, 60

module medalion_base(thick=18, hole=15, wide=90, tall=70, $fn=100) {

     // body

     circle_offset = (wide - tall) / 2;


     linear_extrude(thick) {
	  difference() {
	       hull() {
		    translate([-circle_offset, 0]) {
			 circle(tall);
		    };
		    translate([circle_offset, 0]) {
			 circle(tall);
		    };
	       };

	       circle(hole);

	       translate([30, 0]) {
		    circle(1.5);
	       };
	       translate([-30, 0]) {
		    circle(1.5);
	       };

	       translate([50, 30]) {
		    circle(1.5);
	       };
	       translate([-50, 30]) {
		    circle(1.5);
	       };
	       translate([50, -30]) {
		    circle(1.5);
	       };
	       translate([-50, -30]) {
		    circle(1.5);
	       };
	       translate([0, -60]) {
		    circle(1.5);
	       };
	  };
     };
}


module split_parts(towards) {

     difference() {
	  children(0);
	  children(1);
     };

     translate(towards) {
	  intersection() {
	       children(0);
	       children(1);
	  };
     };
}


module keyed_slide(thick, wide, tall) {
     translate([wide / 2, 0, thick / 2]) {
	  rotate([-90, 0, 0]) {
	       hull() {
		    translate([-wide / 2, 0]) {
			 cylinder(r=thick/2, tall, $fn=4);
		    };

		    translate([wide / 2, 0]) {
			 cylinder(r=thick/2, tall, $fn=4);
		    };
	       };
	  };
     };
};


module medalion() {
     thick = 18;
     split_parts([120, 0]) {
	  medalion_base();

	  translate([-20, -100, -1]) {
	       keyed_slide(thick + 2, 40, 100);
	       // cube([40, 100, thick + 2]);
	  };
     };
}


medalion();
