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

	 rho_step = rho_tip / 16)
	 concat([[0, 0]],
		[for(i = [0:rho_step:rho_tip])
			  involute_point(base_r, i)],
		[for(i = [rho_tip:-rho_step:0])
			  involute_point(base_r, i, tooth_width)]);


module _2d_gear_tooth(modul, teeth, pressure=20, helix=0) {
     polygon(involute_points(modul, teeth, pressure, helix));
}


module 2d_gear(modul, teeth, pressure=20, helix=0) {
     gear_d = modul * teeth;
     gear_r = gear_d / 2;
     clearance =  (teeth < 3)? 0: modul / 6;
     root_d = gear_d - 2 * (modul + clearance);
     root_r = root_d / 2;

     circle(root_r, $fn=100);

     copy_rotate(z=360 / teeth, copies=teeth) {
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


herringbone_gear(2, 24, 20);


// The end.
