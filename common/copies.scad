/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module copy_mirror(plane=[0, 0, 1]) {
     children();
     mirror(plane) children();
}


module copy_translate(x=0, y=0, z=0, copies=1) {
     if(copies) {
	  for(i = [0:copies]) {
	       translate([x * i, y * i, z * i]) {
		    children();
	       };
	  };
     } else {
	  children();
     };
}


module copy_rotate(x=0, y=0, z=0, copies=1) {
     if(copies) {
	  for(i = [0:copies]) {
	       rotate([x * i, y * i, z * i]) {
		    children();
	       };
	  };
     } else {
	  children();
     };
}


module copy_grid(offsets=[0, 0, 0], grid=[1, 1, 1]) {
     copy_translate(x=offsets.x, copies=grid.x-1) {
	  copy_translate(y=offsets.y, copies=grid.y-1) {
	       copy_translate(z=offsets.z, copies=grid.z-1) {
		    children();
	       };
	  };
     };
}


module duplicate(move_v=[0,0,0], rotate_v=[0,0,0]) {
     children();
     translate(move_v) {
	  rotate(rotate_v) {
	       children();
	  };
     };
}


// The end.
