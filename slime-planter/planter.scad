

function known_slime_dimensions() =
     [37.96, 34.93, 28.56];

function scaled_slime_dimensions(scaling) =
     let(known=known_slime_dimensions())
     [known.x * scaling, known.y * scaling, known.z * scaling];


module slime(scaling) {

     // Min X =  36.019802, Max X =  73.980194
     // Min Y =  34.607834, Max Y =  68.995491
     // Min Z = -20.000000, Max Z =  8.556878

     by_x = (36.019802 + 73.980194) / -2;
     by_y = (34.607834 + 68.99549) / -2;
     by_z = 20;

     scale([scaling, scaling, scaling]) {
	  translate([by_x, by_y, by_z]) {
	       import("Pink_Slime_Open_Mouth.stl");
	  };
     };
}


module planter($fn=100) {
     scaling = 3;
     dims = scaled_slime_dimensions(scaling);

     cutout_height = 60;

     difference() {
	  slime(scaling);
	  translate([0, 0, 10]) {
	       cylinder(r=32, cutout_height * 2);
	  };
	  #translate([0, 0, 10]) {
	       cylinder(r=32, cutout_height);
	  };
	  translate([0, 0, -1]) {
	       cylinder(r=32, 5);
	  };
     }
}


planter();

// slime(1);


// The end.
