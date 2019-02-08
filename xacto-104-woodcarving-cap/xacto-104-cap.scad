
base_h = 16;
base_r = 8;

blade_h = 38;
blade_w = 0.9;
blade_d = 8.5;

blade_space_h = blade_h + 2;
blade_space_w = 1;
blade_space_d = blade_d + 1;

relief = (base_r + 4) * 2;

//rotate([0, 90, 0])
difference() {

    // the exterior shape
    union() {

        // base and taper
        hull() {
            cylinder(1, base_r + 2, base_r + 2);
            translate([0, 0, 8]) {
                cylinder(20, base_r + 2, 0);
            };
        };

        // blade sheath
        hull() {
            translate([-10, -2, 0]) {
                cube([20, 4, blade_h - 24]);
            };
            translate([0, 2, base_h + blade_h - 11]) {
                rotate([90, 0, 0]) {
                    cylinder(4, base_r + 2, base_r + 2);
                };
            };
        };
    };


    // relief slots
    translate([-relief / 2, -0.5, -0.5]) {
        cube([relief, 1, 11]);
    };
    rotate([0, 0, 90])
    translate([-relief / 2, -0.5, -0.5]) {
        cube([relief, 1, 11]);
    };


    // interior taper
    translate([0, 0, -0.5]) {
        hull() {
            cylinder(base_h-8, base_r, base_r);
            translate([0, 0, 9]) {
                cylinder(14, base_r, 0);
            };
        };
    };


    // blade slot
    translate([0, 0, -2]) {
    hull() {
        translate([-blade_space_d / 2, -0.5, 10]) {
            cube([blade_space_d, 1, blade_h - 6]);
        };
        translate([0, 0.5, base_h + blade_h - 6]) {
            rotate([90, 0, 0]) {
                cylinder(1, blade_space_d/2, blade_space_d/2);
            };
        };
    };
    };
};
