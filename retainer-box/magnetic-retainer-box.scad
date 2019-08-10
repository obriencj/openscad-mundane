/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GNU LGPL v3+
*/


use <../common/utils.scad>;
use <../common/hinges.scad>;
use <clamshell.scad>;


module magnet_clasp(magnet_dia, magnet_thick, height, $fn=50) {
     difference() {
	  cylinder(r=magnet_dia+1.5, height);
	  translate([0, 0, height - magnet_thick]) {
	       cylinder(r=magnet_dia + 0.1, magnet_thick + 1);
	  };
     };
}


module retainer_box(i_width, i_depth, i_height,
		    wall_thick=1.5, chamfer=4,
		    magnet_spacing=8) {

     // calculate the exterior dimensions based on the interior and
     // thickness
     e_width = i_width + (wall_thick * 2);
     e_depth = i_depth + (wall_thick * 2);
     e_height = i_height + (wall_thick * 2);

     // the half height will be the z offset needed for the hinge and
     // clasp features
     half_height = e_height / 2;

     // we're going to hard-code these settings for all retainer boxes
     gap = 4;
     hinge_barrel = 4;
     hinge_count = 4;

     half_gap = gap / 2;

     // create two clamshell halves mirroring each other
     full_clamshell(i_width, i_depth, i_height,
		    wall_thick, half_gap, chamfer);

     // hinge height needs to be such that the center pin is aligned
     // to the top of the clamshell halves
     hinges(hinge_barrel, half_height + 0.1, half_gap, hinge_count);

     magnet_inset = magnet_spacing + gap + wall_thick + 0.5;

     // set the magnet somewhere where it won't be in the way
     duplicate(rotate_v=[0, 0, 180]) {
	  translate([0, magnet_inset, wall_thick]) {
	       magnet_clasp(2, 4, (half_height - wall_thick) - 0.1);
	  };
     };
}


translate([0, 0, -10])
retainer_box(50, 40, 16, 2, 4);


// The end.
