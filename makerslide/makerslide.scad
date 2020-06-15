//
// a model for makerslide, i.e. aluminum rail extrusion.  This is useful for
// making e.g. riser stands and similar for devices constructed from
// extruded aluminum rail.
//
// contributed by @vathpela
//

//
// this function provides the width of makerslide (on x or y) for models
// that need to include it for e.g. translate() coordinates
//
function makerslide_width() = 20;

//
// make some makerslide or holes to house makerslide
//
// a length of makerslide, originating at (0,0,0)-(20,0,20)
//
// cutout:     false=makerslide, true=a hole to put makerslide in
// length:     how far to extrude in +y space
// railmask:   [bottom, right, top, left] list of boolean values for which
//             rails to carve out from the extrusion (or extrude fill for in
//             the cutout case).  the order assumes we're looking from -x on
//             the left and +x on the right, with +y growing away from the
//             viewer
// flangemask: [top right, top left, bottom left, bottom right] list of boolean
//             values for which corners get a triangular 3.82mm x 3.82mm x 5.4
//             flange pointing up or down for stacking (4x4x5.66 in cutout
//             mode)
//
module makerslide(length=25, cutout=false,
                  railmask=[true,true,true,true],
                  flangemask=[false, false, false, false],
                  $fn=100)
{
    w = makerslide_width();
    h = makerslide_width();
    offset0 = cutout ? 0.2 : 0.2;
    offset1 = cutout ? -0.4 : -0.2;
    offset2 = cutout ? 0.6 : 0;
    offset3 = cutout ? 0.2 : 0;

    // just extrude a right triangle...
    module rt(rtw, rth, l)
    {
        hyp = sqrt(rtw*rtw+rth*rth);

        translate([0, l/2, 0])
            rotate([90, 0, 0]) rotate([0, 0, -45])
                linear_extrude(height=l, center=true)
                    polygon([[0, 0],
                             [rtw, 0],
                             [rtw, rth]]);
    }

    module flange(quadrant)
    {
        fw = cutout ? 4 : 3.82;
        hyp = sqrt(fw*fw*2);

        rotates=[[180, 0, 0],
                 [0, 0, 0],
                 [0, 0, 0],
                 [180, 0, 0]];
        shifts=[[w-hyp/2, length-0.01, h+1],
                [w-hyp/2, -0.01, -1],
                [-hyp/2, -0.01, -1],
                [-hyp/2, length-0.01, h+1]];

        translate(shifts[quadrant])
            rotate(rotates[quadrant]) {
                rt(fw, fw, length+0.02);
                translate([0, 0, -0.01])
                    cube([hyp, length+0.02, 1.02]);
        }
    }

    module rail()
    {
        translate([0,length+0.01,0])
            rotate([90,0,0])
                linear_extrude(height=length+0.02)
                    offset(delta=offset0, chamfer=cutout)
                    offset(delta=offset1, chamfer=cutout)
                    polygon([[8, -0.01 - offset2],
                             [8, 2],
                             [4, 2],
                             [8, 6],
                             [12, 6],
                             [16, 2],
                             [12, 2],
                             [12, -0.01 - offset2]]);
    }

    railshifts = [[0,0,0], [w,0,0], [w,0,h], [0,0,h]];

    difference()
    {
        union()
        {
            translate([0,0,h]) rotate([-90,0,0])
            {
                linear_extrude(height=length)
                    offset(delta=offset3, chamfer=false)
                        square([w, h]);
            }
            for (i = [0:1:3])
            {
                if (flangemask[i] && cutout)
                    flange(i);
            }
        }
        for (i = [0:1:3]) {
            if (railmask[i])
                translate(railshifts[i])
                    rotate([0,-90 * i,0])
                        rail();
            if (!flangemask[i] && !cutout)
                flange(i);
        }
        if (!cutout)
            translate([w/2, -0.01, h/2])
                rotate([-90,0,0])
                    cylinder(d=3.95, h=length+0.02);
    }
}

//
// this is a t-slot insert.  I wouldn't recommend using it for anything that
// needs a bunch of torque.
//
module makerslide_insert($fn=100)
{
    translate([10,6,0])
        rotate([90,0,0])
            difference()
            {
                union()
                {
                    linear_extrude(height=12)
                        polygon([[6,2.2], [6,5], [14,5], [14, 2.2]]);
                    translate([10,5,6])
                        rotate([90,0,0])
                            cylinder(d=3.6, h=4);
                }
                translate([10,5.01,6])
                    rotate([90,0,0])
                        cylinder(d=2.95, h=5.02);
                translate([0,0,-0.01])
                    linear_extrude(height=12.02)
                        offset(delta=0.4, chamfer=true)
                        offset(delta=-0.2, chamfer=true)
                        {
                            polygon([
                                     [0,10],
                                     [4,2],
                                     [8,6],
                                     ]);
                            polygon([
                                     [12,6],
                                     [16,2],
                                     [20,10],
                                     ]);
                        }
            }
}

//////
//
// and some demos
//
//////

// make some makerslide at the default length
makerslide();
// make a box with a cutout to feed it through
difference() {
    translate([-5,10,-5])
        cube([30, 24.98, 30]);
    translate([0,9.99,0])
        makerslide(cutout=true, railmask=[true,false,true,false]);
    // add a M3 screw hole
    translate([19.99,20,10]) rotate([0,90,0]) cylinder(d=2.95, h=5.1, $fn=100);
}
// add some inserts
translate([-10,0,0]) makerslide_insert();
translate([20,20,-10]) rotate([0,-90,0]) makerslide_insert();
