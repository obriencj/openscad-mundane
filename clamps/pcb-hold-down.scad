
hold_down_height = 1.6;
hold_down_diameter = 13;
hold_down_reach = 18;
hold_down_screw_diameter = 4.95;

//
// This is a vaguely teardrop shaped hold-down clamp to hold a pcb workpiece
// flat in the cavity of pcb_work_bracket
//
// h=height of the clamp
// d=outside diameter of the screwed-down part
// r=reach of the pointy bit
// sd=screw diameter
//
// contributed by @vathpela
//
module pcb_hold_down(h=hold_down_height,
                     d=hold_down_diameter,
                     r=hold_down_reach,
                     sd=hold_down_screw_diameter,
                     $fn=200)
{
    difference()
    {
        union()
        {
            cylinder(h=h, d=d);
            linear_extrude(height=h)
                polygon([[0, d/2],
                         [0, -d/2],
                         [r, 0]]);
        }
        translate([0, 0, -0.01])
            cylinder(h=h+0.02, d=sd);
    }
}

pcb_hold_down();
