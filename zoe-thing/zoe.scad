
$fn = 50;

// cylinder(5, 7, 2);





//cylinder(3, 10, 10);

module heart1() {
	rotate([0, 0, 180]) {
		rotate([0, 0, 45])
		hull() {
			cylinder(3, 10, 10);

			translate([-10, 0, 0]) {
				cube([20, 20, 3]);
			};
		};

		translate([-14, 0, 0]) {
			rotate([0, 0, -45]) {
				hull() {
					cylinder(3, 10, 10);
					translate([-10, 0, 0]) {
						cube([20, 20, 3]);
					}
				};
			};
		};
	};
}


module heart() {
	hull() {
		translate([-8, 5, 0])
			cylinder(3, 10, 10);	

		translate([0, -15, 0])
			cylinder(3, 2, 2);
	}

	hull() {
		translate([8, 5, 0])
			cylinder(3, 10, 10);	

		translate([0, -15, 0])
			cylinder(3, 2, 2);
	}
}


module words() {

linear_extrude(3) {
text("owo", size=8, halign="center", valign="center",
	font="Liberation Sans:style=Bold");

translate([0, -7, 0])
text("uwu", size=8, halign="center", valign="center",
	font="Liberation Sans:style=Bold");

translate([0, -14, 0])
text("owo", size=8, halign="center", valign="center",
	font="Liberation Sans:style=Bold");
};
}


module work() {
difference() {
	resize([50, 0, 0], auto=[true, true, false]) {
		heart();
	}

	translate([0, 0, 2])
	resize([45, 0, 0], auto=[true, true, false]) {
		heart();
	}
};

	translate([0, 9, 0])
	words();
}

difference() {
	union() {
		work();
		translate([-20, 11, 0])
			cylinder(3, 3, 3);
	};
	translate([-20, 11, -1]) {
		cylinder(5, 1.5, 1.5);
	}
}

// The end.
