
use <../makerslide/makerslide.scad>
use <../common/copies.scad>

function xcarve_stand_width() = makerslide_width() * 1.5;
function xcarve_stand_length() = makerslide_width() * 3 / 2;

module xcarve_stand($fn=200)
{
    M3 = 2.95;
    M5 = 4.95;

    scale = 1.5;
    w = xcarve_stand_width() / scale;
    h = 130-w;
    l = xcarve_stand_length();
    // width of the annoying flange on the original x-carve gantry beams
    // (plus 0.2mm of slop)
    fw = 4;
    topw = 22;

    shift = scale/4;

    rotate([90, 0, 0])
    translate([-(w*scale)/2, 0, -(h+l)/2])
    difference()
    {
        cube([w*scale, l, w + h+w*0.2]);
        union()
        {
            translate([0, -0.02, h])
                makerslide(length=topw+0.04, cutout=true,
                           railmask=[true, false, false, false]);
            translate([0, topw-0.02, h])
                makerslide(length=l-topw+0.06, cutout=true,
                           railmask=[true, false, false, false]);
        }
        translate([-0.02, topw, h+makerslide_width()])
            cube([w*scale+0.04, l, 11]);
        // add some M5 screw holes
        translate([w/2, l-w/2, w/2+h])
            rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);
        translate([w/2, w/2, w/2+h])
            rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);

        translate([w*shift*4/5, -0.1, w*shift*3/4])
        {
            makerslide(length=l+0.2, cutout=true,
                       railmask=[true, false, false, false],
                       flangemask=[false, false, true, false]);
            translate([w/2, l-w/2, w/2])
                rotate([0,90,0]) cylinder(d=M5, h=w, $fn=100);
            translate([w/2, w/2, w/2])
                rotate([0,90,0]) cylinder(d=M5, h=w, $fn=100);

            translate([0, 0, w-0.01])
                makerslide(length=l+0.2, cutout=true,
                           railmask=[false, false, true, false],
                           flangemask=[false, false, false, true]);
            translate([-w/2, l-w/2, w*3/2])
                rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);
            translate([-w/2, w/2, w*3/2])
                rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);
            translate([w/2, l-w/2, w*3/2])
                rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);
            translate([w/2, w/2, w*3/2])
                rotate([0,90,0]) cylinder(d=M5, h=w+1, $fn=100);
        }
    }
}

module xcarve_stand_pad($fn=200)
{
    difference()
    {
        cube([xcarve_stand_width() + 4, xcarve_stand_length() + 4, 4]);
        translate([2, 2, 2])
            cube([xcarve_stand_width(), xcarve_stand_length(), 4]);
    }
}

module demo()
{
    l = makerslide_width()*3/2;
//    for (i=[-3:2:0])
//    {
//        copy_mirror([1, 0, 0])
//            translate([i*l, 0, 0])
//                xcarve_stand();
//    }
    isomers(ns=[2, 2, 1], size=[l, 115, l]) xcarve_stand();
}

module pad_demo()
{
    for (i=[0:1:3]) {
        translate([-xcarve_stand_width()*2, (xcarve_stand_length()+6)*i, 0])
            xcarve_stand_pad();
    }
}

demo();
pad_demo();
