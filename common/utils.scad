/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <copies.scad>;


module double_sided(y_axis, thickness) {
     translate([0, 0, thickness / 2]) {
	  duplicate(move_v=[0, y_axis, 0],
		    rotate_v=[180, 0, 0]) {
	       children();
	  };
     };
}


module 2d_cutout(thick, position=[0, 0, 0], overshoot=0.05) {

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


module 2d_words(txt_v, size=6, spacing=0,
		font="Liberation Sans", style="Bold",
		halign="center", valign="center", $fn=50) {

     /* 2d lines of text */

     fontstyle = str(font, ":style=", style);

     lspacing = (spacing == 0)? size + 2: spacing;

     for(i = [0 : len(txt_v) - 1]) {
	  translate([0, i * -lspacing, 0])
	       text(txt_v[i], size=size, font=fontstyle,
		    halign=halign, valign=valign);
     };
}


module words(text_v, size=6, thick=5, spacing=0,
             font="Liberation Sans", style="Bold",
             halign="center", valign="center", $fn=50) {

     /* extruded lines of text */

     linear_extrude(thick) {
	  2d_words(text_v, size, spacing, font, style,
		   halign, valign, $fn);
     };
}


//
// rotate the results of linear_extrude() so instead of extruding towards
// positive z, it's extruding towards positive y, with the object in the
// positive xz space.
//
// contributed by @vathpela
//
module xy_to_xyz()
{
    rotate([90, 0, 0])
        mirror([0, 0, 1])
            children();
}

//
// extrude a 2d polygon as if it's in the positive xz space, extruding into
// positive y.
//
// contributed by @vathpela
//
module linear_extrude_y(height=1, center=false, convexity=10, twist=0,
                        slices=20, scale=1.0, $fn=16)
{
    xy_to_xyz()
        linear_extrude(height=height, center=center,
                       convexity=convexity, twist=twist,
                       slices=slices, scale=scale, $fn=$fn)
            children();
}



// The end.
