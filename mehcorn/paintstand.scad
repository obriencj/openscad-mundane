

module honeycomb(x, y, r) {
     gap = 2;
     hgap = gap / 2;

     x_step = (2 * r) + gap;
     x_copies = floor(x / x_step);

     y_step = 2 * (r + gap);
     y_copies = floor(y / y_step);

     intersection() {
	  square([x, y]);

	  translate([0, 0]) {
	       copy_translate(y=y_step, copies=y_copies) {
		    copy_translate(x=x_step, copies=x_copies) {
			 copy_translate(x=r + hgap, y=r + gap, copies=1) {
			      rotate([0, 0, 90]) {
				   circle(r, $fn=6);
			      };
			 };
		    };
	       };
	  };
     };
}


module standoff(tall, base, r=5, base_thick=2, $fn=8) {
     translate([0, 0, base_thick]) {
	  linear_extrude(tall) {
	       difference() {
		    circle(r);
		    circle(r-base_thick);
	       };
	  };
     };

     honey_base = base - (base_thick * 2);

     linear_extrude(base_thick) {
	  difference() {
	       square([base, base], true);
	       circle(r-base_thick);

	       /* // honeycomb is cute and all, but takes like 5 times
		  // as long to print.

		  difference() {
		  translate([-honey_base/2, -honey_base/2]) {
		  honeycomb(honey_base, honey_base, 2.5);
		  };
		  circle(r * 2);
	       };
	       */
	  };
     };
}


module copy_translate(x=0, y=0, z=0, copies=1) {
     for(i = [0:copies]) {
          translate([x * i, y * i, z * i]) {
               children();
          };
     };
}


module standoff_grid(rows, cols, tall, base, r, base_thick=2) {
     copy_translate(x=base, copies=cols-1) {
	  copy_translate(y=base, copies=rows-1) {
	       translate([base / 2, base / 2]) {
		    standoff(tall, base, r, base_thick);
	       };
	  };
     };
     linear_extrude(base_thick * 2) {
	  let(bx = base * cols, by = base * rows, bh = base_thick * 2) {
	       difference() {
		    square([bx, by]);
		    translate([base_thick, base_thick]) {
			 square([bx - bh, by - bh]);
		    };
	       };
	  };
     };
}


standoff_grid(2, 2, 30, 50, r=5, base_thick=1.5);

translate([-105, 0]) {
     standoff_grid(2, 2, 10, 50, r=10, base_thick=1.5);
};

//standoff(30, 50);
