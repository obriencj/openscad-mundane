use <../common/geometry.scad>;
use <../common/knurledFinishLib.scad>;
use <knob.scad>;

// of the two powermates I have, the gen1 is 43.99, the gen2 is 43.75, which
// makes the gen1 a *little* tight fit; use plus_id to enlarge it
top_id = 44;      // +-------------+
bottom_id = 42.5; // |    44mm ^   | 11mm
taper_h = 5;      // |   v 42.5mm  |
top_h = 16;       // \_____________/ 5mm

od = top_id + 2;
echo("od:", od, "top_id:", top_id);
//thickness = (od - top_id) / 3;
thickness = 0.6;
echo("thickness:", thickness);
h = top_h + thickness;
echo("top_h:", top_h, "h:", h);

dimple_depth = thickness * 11 / 2;
dimple_diameter = od / 3;
//dimple_depth = 1;
//dimple_diameter = 6;

dimple_offset = dimple_diameter / 2;

module inside_cap($fa=$fa/4, $fs=$fs*3/8, plus_id=0) {
    rotate_extrude(angle=360, convexity=1)
        polygon(points=[[0,top_h],[(top_id+plus_id)/2,top_h],
                        [(top_id+plus_id)/2,taper_h],
                        [(bottom_id+plus_id)/2,0],
                        [0,0], [0,taper_h],
                        [0,top_h]]);
}

module cap() {
    union()
    {
        difference()
        {
            //%scale([od/top_id, od/top_id, h/top_h]) inside_cap();
            union()
            {
                minkowski()
                {
                    translate([0,0,thickness*1.94])
                        inside_cap();
                    translate([0,0,-thickness])
                        sphere(d=thickness*2, $fs=$fs*3/8);
                }
            }
        }
    }
}

module dimple($fa=$fa/3, $fs=$fs*3/8) {
    // even doing this right, the dimple diameter isn't perfect, because it's
    // too difficult to predict the borders of minkowski() results, and there's
    // no obvious (to me) way to do "move this until its highest point is at
    // z=foo"
    r = circle_r_from_chord(dimple_depth, dimple_diameter);

    translate([-dimple_offset, 0, r - dimple_depth])
    //rotate([0,20,0])
    //scale([2,1,1])
        sphere(r=r);
}

module powermate_cover($fa=2, $fs=1/2, plus_id=0) {
    translate([0,0,h]) rotate([180,0,0])
    union()
    {
        difference()
        {
            cap();
            inside_cap(plus_id=plus_id);
            // this translation was arrived at by bisecting until the
            // intersection with the dimple was the same size as if we'd done
            // the scale() above instead of the minkowski...
            translate([0,0,-0.039]) // dunno
                //translate([0,0,-thickness*2])
                //    cylinder(d=bottom_id - thickness * 2, h=thickness*3);
                translate([0,0,-4])
                    cylinder(d=top_id+plus_id, h=top_h+3);

            translate([(top_id+plus_id)/2-thickness*3,0,h])
                dimple();
        }
    }
}

module knurled_powermate_cover($fa=2, $fs=1/2, plus_id=0)
{
    translate([0,0,h]) rotate([180,0,0])
    union()
    {
        difference()
        {
            union()
            {
                cap();
                translate([0,0,taper_h])
                    knurled_cyl(top_h-taper_h+thickness*2.1, top_id+thickness*7, 6, 8, 1, 3, 35);
                    //knurled_cyl(top_h-taper_h+thickness*2.1, top_id+thickness*7, 6, 8, 2, 2, 35);
            }
            inside_cap(plus_id=plus_id);
            // this translation was arrived at by bisecting until the
            // intersection with the dimple was the same size as if we'd done
            // the scale() above instead of the minkowski...
            translate([0,0,-0.039]) // dunno
                //translate([0,0,-thickness*2])
                //    cylinder(d=bottom_id - thickness * 2, h=thickness*3);
                translate([0,0,-4])
                    cylinder(d=top_id+plus_id, h=top_h+3);

            translate([(top_id+plus_id)/2-thickness*3,0,h])
                dimple();
        }
    }
}

module powermate_knob_inside()
{
    translate([0, 0, -0.1])
        cylinder(h=7.01, d=40);
}

module powermate_knob($fa=2, $fs=1/2, plus_id=0)
{
    translate([0,0,h]) rotate([180,0,0])
    union()
    {
        difference()
        {
            inside_cap(plus_id=plus_id);
            powermate_knob_inside();
            translate([0,0,-thickness])
                knob_clearer();
        }
        knob();
    }
    powermate_cover(plus_id=plus_id);
}

module knurled_powermate_knob($fa=2, $fs=1/2, plus_id=0)
{
    powermate_knob(plus_id=plus_id);
    knurled_powermate_cover(plus_id=plus_id);
}

//translate([0,-od,0])
//    powermate_knob($fa=10, $fs=1, plus_id=0.1);
//translate([0,od,0])
//    knurled_powermate_knob($fa=20, $fs=2, plus_id=0.1);
//translate([-od,0,0])
//    powermate_cover($fa=10, $fs=1, plus_id=0.1);
translate([od,0,0])
    knurled_powermate_cover($fa=2, $fs=1/2, plus_id=0.1);
