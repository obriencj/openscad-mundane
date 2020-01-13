

module divider(x, y, tall, thick=1, $fn=100) {

     dt = thick * 2;

     minkr = thick * 5;
     minkx = x - dt - (2 * minkr);
     minky = y - dt - (2 * minkr);

     difference() {
	  cube([x, y, tall]);

	  translate([minkr + thick, minkr + thick, minkr + thick]) {
	       minkowski() {
		    sphere(minkr);
		    cube([minkx, minky, tall]);
	       };
	  };
     };
}


module full_divider() {
     divider(190, 100, 80);
};


module half_divider() {
     divider(95, 100, 80);
};


module side_divider() {
     divider(95, 200, 80);
};



translate([-95, -100, 0]) full_divider();
translate([-100, 10, 0]) half_divider();
translate([-100, 120, 0]) half_divider();
translate([5, 10, 0]) side_divider();


// The end.
