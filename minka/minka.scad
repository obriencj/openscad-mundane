

module minka_tag_1(wide=50, tall=20, thick=1.5, inset=1, $fn=100) {
     htall = tall / 2;
     difference() {
	  linear_extrude(thick) {
	       hull() {
		    translate([htall, 0, 0]) {
			 circle(htall);
		    };
		    translate([wide - htall, 0, 0]) {
			 circle(htall);
		    };
	       };
	  };

	  translate([(wide / 2), 0, thick - inset]) {
	       linear_extrude(thick) {
		    text(" minka", font="Liberation Sans:style=Bold",
			 size=tall/2,
			 halign="center",
			 valign="center");
	       };
	  };

	  translate([0, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([htall / 2, htall / 3]) {
			 circle(1);
		    };
		    translate([htall / 2, -htall / 3]) {
			 circle(1);
		    };
	       };
	  };
     };
}


module minka_tag_2(wide=50, tall=20, thick=1.5, inset=1, $fn=100) {
     htall = tall / 2;
     itall = htall - inset;

     difference() {
	  linear_extrude(thick) {
	       hull() {
		    translate([htall, 0, 0]) {
			 circle(htall);
		    };
		    translate([wide - htall, 0, 0]) {
			 circle(htall);
		    };
	       };
	  };

	  translate([inset, 0, inset]) {
	       linear_extrude(thick) {
		    hull() {
			 translate([itall, 0, 0]) {
			      circle(itall);
			 };
			 translate([wide - htall - inset, 0, 0]) {
			      circle(itall);
			 };
		    };
	       };
	  };


	  translate([htall / 2, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([0, htall / 3]) {
			 circle(1);
		    };
		    translate([0, -htall / 3]) {
			 circle(1);
		    };
	       };
	  };
     }

     translate([(wide / 2), 0, 0]) {
	  linear_extrude(thick) {
	       text(" minka", font="Liberation Sans:style=Bold",
		    size=tall/2,
		    halign="center",
		    valign="center");
	  };
     };
}


translate([0, 15, 0])
minka_tag_1();

translate([0, -15, 0])
minka_tag_2();


// The end.
