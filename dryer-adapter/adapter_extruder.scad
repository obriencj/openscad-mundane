

use <adapter.scad>;


module adapter_extruder(tubing_od, extruder_od) {
     union() {
	  translate([0, 0, 16]) {
	       rotate([180, 0, 0]) {
		    adapter_tube(extruder_od);
	       };
	  };
	  adapter_tube(tubing_od);
     }
}


adapter_extruder(4.1, 8.55);


// The end.
