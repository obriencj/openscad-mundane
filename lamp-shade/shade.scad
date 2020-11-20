
use <../common/copies.scad>;


module keyways(thick, r, $fn=200) {
     copy_rotate(z=120, copies=2) {
          translate([0, 0, 3.5]) {
	       rotate_extrude(angle=40) {
		    translate([r - (thick/2), 0]) {
			 square([thick, 4]);
		    };
	       };
	  };
	  translate([0, 0, -1]) {
	       rotate_extrude(angle=20) {
		    translate([r - (thick/2), 0]) {
			 square([thick, 8]);
		    };
	       };
	  };
     };
}


module base(thick=3, r=51/2, tall=12, $fn=200) {
     difference() {
	  cylinder(tall, r=r);
	  translate([0, 0, -1]) {
	       cylinder(tall + 2, r=r-thick);
	  };
	  keyways(thick, r);
     };
}


module hollow_sphere(thick=3, r, $fn=300) {
     rotate_extrude(angle=360) {
	  difference() {
	       circle(r);
	       circle(r - thick);
	       translate([0, -(r + 1)]) {
		    square([r + 1, 2 * (r + 1)]);
	       };
	  };
     };
}


module shade(thick=3, base_r=51/2, $fn=200) {
     fattest = 160;
     factor = 1.7;

     fudge = 8;
     height = fattest * factor;

     translate([0, 0, height/2]) {
	  difference() {
	       translate([0, 0, -fudge]) {
		    resize(newsize=[fattest, fattest, height]) {
			 hollow_sphere(thick, fattest);
		    };
	       };
	       cylinder(r=(fattest + 2) /1, height / 2);
	       translate([0, 0, (-height / 2) - fudge]) {
		    cylinder(r=base_r - thick, 20);
	       };
	  };
     };
}


module lamp_shade(cut=false) {
     if(cut) {
	  base();
	  translate([0, 0, 10]) {
	       difference() {
		    translate([0, 0, 12]) {
			 shade();
		    };
		    cylinder(r=52/2, 12, $fn=100);
	       };
	  };

     } else {
	  base();
	  translate([0, 0, 12]) {
	       shade();
	  };
     };
};


lamp_shade(cut=true);


// The end.
