

module minka_tag_sample_1(wide=50, tall=18, thick=1.5, inset=0.5, $fn=100) {
     htall = tall / 2;
     tsize = tall / 1.8;

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

	  translate([(wide / 2) + 1, 0, thick - inset]) {
	       linear_extrude(thick) {
		    text("minka", font="Liberation Sans:style=Bold",
			 size=tsize,
			 halign="center",
			 valign="center");
	       };
	  };

	  translate([0, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([htall / 2, htall / 3.5]) {
			 circle(1);
		    };
		    translate([htall / 2, -htall / 3.5]) {
			 circle(1);
		    };
	       };
	  };
     };
}


module minka_tag_sample_2(wide=50, tall=18, thick=1.5, inset=1, $fn=100) {
     htall = tall / 2;
     itall = htall - inset;

     tsize = tall / 1.8;

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
		    translate([0, htall / 3.5]) {
			 circle(1);
		    };
		    translate([0, -htall / 3.5]) {
			 circle(1);
		    };
	       };
	  };
     }

     translate([(wide / 2) + 1, 0, 0]) {
	  linear_extrude(thick) {
	       text("minka", font="Liberation Sans:style=Bold",
		    size=tsize,
		    halign="center",
		    valign="center");
	  };
     };
}


module minka_tag_sample_3(wide=50, tall=15, thick=1.25, inset=1, $fn=100) {
     htall = tall / 2;
     itall = htall - inset;

     tsize = 11; // tall - 4;

     holesize = 0.75;
     holeoffset = 2.5;

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


	  translate([holeoffset, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([0, holeoffset / 2]) {
			 circle(holesize);
		    };
		    translate([0, -holeoffset / 2]) {
			 circle(holesize);
		    };
	       };
	  };

	  translate([wide - holeoffset, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([0, holeoffset / 2]) {
			 circle(holesize);
		    };
		    translate([0, -holeoffset / 2]) {
			 circle(holesize);
		    };
	       };
	  };
     }

     translate([wide / 2, 0, 0]) {
	  linear_extrude(thick) {
	       text("minka", font="Liberation Sans:style=Bold",
		    size=tsize,
		    halign="center",
		    valign="center");
	  };
     };
}


module minka_tag_sample_4(wide=25, tall=8, thick=1.2, inset=0.8, $fn=100) {
     htall = tall / 2;
     itall = htall - inset;

     tsize = 5; // tall - 4;

     holesize = 0.75;
     holeoffset = 1.55;

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

	  translate([0, 0, -0.5]) {
	       linear_extrude(thick + 1) {
		    translate([holeoffset, 0]) {
			 circle(holesize);
		    };
		    translate([wide - holeoffset, 0]) {
			 circle(holesize);
		    };
	       };
	  };
     };

     translate([wide / 2, 0, 0]) {
	  linear_extrude(thick) {
	       text("minka", font="Liberation Sans:style=Bold",
		    size=tsize,
		    halign="center",
		    valign="center");
	  };
     };
}



minka_tag_sample_4();


// The end.
