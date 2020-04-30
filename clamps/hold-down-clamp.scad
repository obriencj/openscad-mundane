//
// flat-clamp.scad, "by" pjones
//
// This is basically a clone of the hold-down clamps that come with an
// X-Carve.  It's not exact, but it's close enough.  You'll need something
// like a EZ-lock thread insert for the pivot, and a wingnut or bolt and
// washer that fit with your wasteboard or t-slots for the anchor.
//
// The default pivot size here is for one I got off the internet; it doesn't
// match the original.
//

module flat_clamp(pivot_d=[9.6, 7, 6], anchor_w=5.5, h=9.5, l=110, $fn=200)
{
    w = 40;
    pivot_pos = [l - pivot_d[2] * 1.75, w/2, -0.02];
    slot_sz = [l - anchor_w * 9 - anchor_w, anchor_w, h+0.04];
    slot_pos = [l - anchor_w * 5 - slot_sz[0], w/2-slot_sz[1]/2, -0.02];
    slot_min_pos = [slot_pos[0],
                    slot_pos[1] + slot_sz[1]/2,
                    slot_pos[2]];
    slot_max_pos = [slot_pos[0] + slot_sz[0],
                    slot_pos[1] + slot_sz[1]/2,
                    slot_pos[2]];

    difference()
    {
        cube([l, w, h]);
        translate(pivot_pos) {
            cylinder(h=h+0.04, r1=pivot_d[2]/2, r2=pivot_d[1]/2);
            translate([0, 0, h-0.5])
            cylinder(h=0.5+0.05, d=pivot_d[0]);
        }
        translate(slot_pos) cube(slot_sz);
        translate(slot_min_pos) cylinder(h=h+0.04, d=slot_sz[1]);
        translate(slot_max_pos) cylinder(h=h+0.04, d=slot_sz[1]);
        rotate([0, -30, 0]) translate([-1, -1, -1]) cube([l, w+2, h*3]);

        for (i = [-1:2:1])
        {
            translate([-l/4, w*3/16 + i*w*7/8, -0.02])
            linear_extrude(height=h+0.04)
                minkowski() {
                    square([l, w*5/8]);
                    circle(d=w*3/8);
                }
        }
    }
}

flat_clamp();
