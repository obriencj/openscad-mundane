
use <magnetic-plaque.scad>;


plaque(width=100, height=50, rim=5, thick=4, inset=2) {

     // title
     translate([45, 25, 0])
	  linear_extrude(height=5)
	  text("Zoe O'Brien",
	       size=11, font="Liberation Sans:style=Bold",
	       halign="center", valign="center");

     // subtitle
     translate([45, 12, 0])
	  linear_extrude(height=5)
	  text("~ owo uwu owo ~",
	       size=6, font="Liberation Sans:style=Bold Italic",
	       halign="center", valign="center");
}


// The end.
