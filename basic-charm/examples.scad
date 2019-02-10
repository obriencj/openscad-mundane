
use <basic-charm.scad>;


CharmStyle1() {
     CharmLetters(letters="1");
}

translate([25, 0, 0])
CharmStyle2() {
     CharmLetters(letters="2");
}

translate([0, 25, 0])
CharmStyle3() {
     CharmLetters(letters="3");
}

translate([25, 25, 0])
CharmStyle4() {
     CharmLetters(letters="4");
}

translate([0, -25, 0])
CharmStyle5() {
     CharmLetters(letters="5");
}

translate([25, -25])
CharmStyle6() {
     CharmLetters(letters="6");
}

translate([50, 0])
CharmStyle6() {
     CharmLetters(letters="♥", font="Arial");
}

translate([50, -25])
CharmStyle2() {
     CharmLetters(letters="♫", font="Arial");
}


// The end.
