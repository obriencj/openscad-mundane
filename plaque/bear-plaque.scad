
use <magnetic-plaque.scad>;


module words(txt_v, size=6, thick=5,
	     font="Liberation Sans", style="Bold",
	     halign="center", valign="center", $fn=100) {

     linear_extrude(height=thick) {
	  for(i = [0 : len(txt_v) - 1]) {
	       translate([0, i * -(size + 2), 0])
		    text(txt_v[i], size=size,
			 font=str(font, ":style=", style),
			 halign=halign, valign=valign);
	  }
     }
}


difference() {
     plaque(width=100, height=50, rim=5, thick=4, inset=2) {

	  // title
	  translate([0, 7, 0])
	       words(["Bear"], size=18);

	  // subtitle
	  translate([0, -9, 0])
	       words(["\"Keep your hands off of", "my tools, you goober.\""],
		     size=3.5,
		     style="Bold Italic");
     };

     translate([50, 2, 3.75]) {
	  words(["Littlebear O'Brien, est. 1986"],
		size=3, style="Bold");
     };

     translate([50, 47, 3.75]) {
	  words(["these tools ain't fo' fools"],
		size=3, style="Bold");
     };
};



// The end.
