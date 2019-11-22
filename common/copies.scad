/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module copy_mirror(plane=[0, 0, 1]) {
     children();
     mirror(plane) children();
}


module copy_translate(x=0, y=0, z=0, copies=1) {
     for(i = [0:copies]) {
	  translate([x * i, y * i, z * i]) {
	       children();
	  };
     };
}


module copy_rotate(x=0, y=0, z=0, copies=1) {
     for(i = [0:copies]) {
	  rotate([x * i, y * i, z * i]) {
	       children();
	  };
     };
}


// The end.
