/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module duplicate(move_v=[0,0,0], rotate_v=[0,0,0]) {
     children();
     translate(move_v) {
	  rotate(rotate_v) {
	       children();
	  };
     };
}


module double_sided(y_axis, thickness) {
     translate([0, 0, thickness / 2]) {
	  duplicate(move_v=[0, y_axis, 0],
		    rotate_v=[180, 0, 0]) {
	       children();
	  };
     };
}


module 2d_cutout(thick, position, overshoot=0.05) {

     // overshoot is used to prevent weird z-clipping artifacts, it
     // ensures that the subtracted shape is slightly thicker than the
     // solid body and passes both faces fully. If the cutout is not
     // meant to go all the way through, set overshoot to 0 and
     // overstate the thickness by some amount.

     oz = thick + (overshoot * 2);
     op = [position.x, position.y, position.z - overshoot];

     difference() {
	  children(0);
	  translate(op) {
	       linear_extrude(oz) {
		    children(1);
	       };
	  };
     };
}


module rounded_plate(width, height, thickness, turn_r=5.1, $fn=50) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  linear_extrude(thickness) {
	       minkowski() {
		    square([width - turn_d, height - turn_d]);
		    circle(turn_r);
	       };
	  };
     };
}


module words(txt_v, size=6, thick=5, spacing=0,
             font="Liberation Sans", style="Bold",
             halign="center", valign="center", $fn=50) {

     fontstyle = str(font, ":style=", style);

     lspacing = (spacing == 0)? size + 2: spacing;

     linear_extrude(height=thick) {
          for(i = [0 : len(txt_v) - 1]) {
               translate([0, i * -lspacing, 0])
                    text(txt_v[i], size=size, font=fontstyle,
                         halign=halign, valign=valign);
          };
     };
}


// The end.
