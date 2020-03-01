/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  This is a refactored derivative of the spur and double-helix gears
  from https://www.thingiverse.com/thing:1604369
*/


use <../common/copies.scad>;


RAD = 57.29578;

function radians(x) = x / RAD;
function degrees(x) = x * RAD;


function involute_point(r, rho, off=undef) =
     let(p = r / cos(rho),
	 t = degrees(tan(rho) - radians(rho)),
	 ot = off? off - t: t,
	 x = p * cos(ot),
	 y = p * sin(ot))
     [x, y];


function involute_points(modul, teeth, pressure=20, helix=0) =
     let(gear_d = modul * teeth,
	 gear_r = gear_d / 2,

	 clearance =  (teeth < 3)? 0: modul / 6,
	 root_d = gear_d - 2 * (modul + clearance),
	 root_r = root_d / 2,

	 alpha_spur = atan(tan(pressure) / cos(helix)),
	 base_d = gear_d * cos(alpha_spur),
	 base_r = base_d / 2,

	 tip_d = gear_d + modul * ((modul < 1)? 2.2 : 2),
	 tip_r = tip_d / 2,
	 rho_tip = acos(base_r / tip_r),
	 rho_base = acos(base_r / gear_r),

	 phi_a = degrees(tan(rho_base) - radians(rho_base)),
	 tooth_width = (180 * 0.95) / teeth + 2 * phi_a,
	 tw = tooth_width / 2,

	 steps = 16 * ceil(modul),
	 rho_step = rho_tip / steps)

	 concat([[0, 0]],
		[for(i = [0:1:steps])
			  involute_point(base_r, i * rho_step, tw)],
		[for(i = [-steps:1:0])
			  involute_point(base_r, i * rho_step, -tw)]);


function root_radius(modul, teeth) =
     let(gear_d = modul * teeth,
	 gear_r = gear_d / 2,
	 clearance =  (teeth < 3)? 0: modul / 6,
	 root_d = gear_d - 2 * (modul + clearance),
	 root_r = root_d / 2)
     root_r;


module _2d_gear_tooth(modul, teeth, pressure=20, helix=0) {
     polygon(involute_points(modul, teeth, pressure, helix));
}


module 2d_gear(modul, teeth, pressure=20, helix=0) {

     root_r = root_radius(modul, teeth);
     circle(root_r, $fa=1, $fs=modul/2);

     copy_rotate(z=360 / teeth, copies=teeth-1) {
	  _2d_gear_tooth(modul, teeth, pressure, helix);
     };
}


module gear(modul, teeth, width, pressure=20, helix=0) {

     torsion_angle = helix?
	  let(gear_d = modul * teeth,
	      gear_r = gear_d / 2)
	  RAD * width / (gear_r * tan(90 - helix)):
	  0;

     linear_extrude(width, twist=torsion_angle) {
	  2d_gear(modul, teeth, pressure, helix);
     };
}


module herringbone_gear(modul, teeth, width, pressure=20, helix=30) {

     h_width = width / 2;

     translate([0, 0, h_width]) {
	  copy_mirror([0, 0, 1]) {
	       gear(modul, teeth, h_width, pressure, helix);
	  };
     };
}


herringbone_gear(1.5, 24, 20);


// The end.
