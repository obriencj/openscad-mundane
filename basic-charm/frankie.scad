
use <basic-charm.scad>;

module charm(letter, x, y) {
     translate([x, y])
     CharmStyle3() {
	  CharmLetters(letter);
     };
};


charm("F", -22, 22);
charm("r", 0, 22);
charm("a", 22, 22);
charm("n", -22, 0);
charm("k", 0, 0);
charm("i", 22, 0);
charm("e", -22, -22);


// The end.
