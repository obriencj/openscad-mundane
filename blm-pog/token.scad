

pog_diameter = 41.37;
pog_radius = pog_diameter / 2;
pog_thickness = 1.25;


module blm_v1(r=20, thick=4, center=true, $fn=50) {
     diam = r * 2;
     linear_extrude(thick) {
	  resize([diam, diam, 0]) {
	       import("blm_v1.svg", center=center);
	  };
     };
}


module blm_v1_notext(r=20, thick=4, center=true, $fn=50) {
     trim = 3.5;
     offset_d = (r + trim) * 2;

     linear_extrude(thick) {
	  intersection() {
	       circle(r);
	       resize([offset_d, offset_d, 0]) {
		    import("blm_v1.svg", center=center);
	       };
	  };
     };
}


module dupliflip(vec=[180, 0, 0]) {
     children();
     rotate(vec) {
	  children();
     };
}


module pog($fn=50) {
     difference() {
	  cylinder(pog_thickness, pog_radius, pog_radius, center=true);
	  translate([0, 0, 0.25]) {
	       children();
	  };
     };
}


module pog_2sided($fn=50) {
     difference() {
	  cylinder(pog_thickness, pog_radius, pog_radius, center=true);

	  translate([0, 0, 0.25]) {
	       children();
	  };
	  rotate([0, 180, 0]) {
	       translate([0, 0, 0.5]) {
		    children();
	       }
	  };
     };
}


module invert(r=20, thick=4, $fn=50) {
     difference() {
	  cylinder(thick, r, r);
	  children();
     };
}


/*
translate([-24, 24, 0])
pog() {
     blm_v1_notext();
};
*/

// translate([+24, 24, 0])
pog_2sided() {
     blm_v1_notext();
};

/*
translate([-24, -24, 0])
pog() {
     blm_v1();
};

translate([+24, -24, 0])
pog_2sided() {
     blm_v1();
};
*/

// The end.
