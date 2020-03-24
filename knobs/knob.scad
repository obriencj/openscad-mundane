thickness = 2.5;
// 6mm or so diameter, 4.5mm on the flat side, 7.6mm deep, 16mm hole around it
inner_shell_id = 6.35;
inner_shell_od = 6.35 + thickness * 2;
inner_shell_notch = 1.5;
inner_shell_depth = 7.6;
outer_shell_id = 16;
outer_shell_od = 16 + thickness * 2;
outer_shell_depth = inner_shell_depth + thickness;
outer_shell_height = inner_shell_depth + thickness * 2;

// use this with difference() from your part to make sure there's appropriate
// area
module knob_clearer($fa=5, $fs=0.5)
{
    rotate([180,0,0])
    translate([0,0,-(outer_shell_height+0.1)])
        cylinder(d=outer_shell_od - 0.2, h=outer_shell_height*2);
}

// then use this with union outside of that to add the base of the knob
module knob($fa = 5, $fs = 0.5, slop=0.1)
{
    translate([0,0,outer_shell_height])
    rotate([180,0,0])
    union()
    {
        difference()
        {
            cylinder(d=outer_shell_od, h=outer_shell_height);
            translate([0,0,thickness])
                cylinder(d=outer_shell_id, h=outer_shell_depth+0.1);
        }
        difference()
        {
            translate([0,0,thickness-0.1])
                cylinder(d=inner_shell_od, h=inner_shell_depth+0.2);
            translate([0,0,thickness])
                difference()
                {
                    cylinder(d=inner_shell_id+slop*2, h=inner_shell_depth+0.2);
                    translate([inner_shell_id/2-inner_shell_notch, -inner_shell_od/2, -0.1])
                        cube([inner_shell_od, inner_shell_od, inner_shell_depth+0.4+slop]);
                }
        }
    }
}

knob_clearer();
knob();
