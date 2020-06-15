use <xcarve-stand.scad>

difference()
{
    mirror([0, 1, 0]) xcarve_stand();

//    l = makerslide_width()*3/2;
//    translate([-1, l/2+0.2, -25])
//        cube([35, l/2, 200]);
//    translate([-1, -1, -25])
//        cube([35, l/2+1, 200]);
}
