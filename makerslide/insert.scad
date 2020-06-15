insert_height = 2.10;
insert_width = 9.00;
screw_diameter=  5.00;

//
// this is a makerslide t-nut insert that expects to be fitted with a brass
// thread insert that melts nicely into a 5mm hole (by default)
//
module insert(h=insert_height, w=insert_width, d=screw_diameter, $fn=200)
{
    l = d * 2.5;
    difference()
    {
        cube([w, l, h]);
        translate([w/2, l/2, -0.1])
        cylinder(d=d-0.1, h=h+0.2);
    }
}

insert();
