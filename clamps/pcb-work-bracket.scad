use <../common/geometry.scad>
use <../common/threads.scad>

pcb_w = 51.25;
pcb_d = 76.25;
pcb_h = 1.60;
hold_down_pitch = 75.00;

//
// this is a bracket to attach a small pcb workpiece to the wasteboard of my
// CNC, laser etcher, or PnP machines.
//
// dimensions for the pcb are provided by pcb=[x,y,z]
// hold_down_pitch is the spacing on which you can clamp to the mill's
// wasteboard
//
// contributed by @vathpela
//
module pcb_work_bracket(pcb=[pcb_w, pcb_d, pcb_h], hdp=hold_down_pitch,
                        debug=false, $fn=200)
{
    pcbw = pcb[0];
    pcbl = pcb[1];
    pcbh = pcb[2];

    anchor_d = [9.62, 7, 6];
    anchor_h = 10;

    space = ceil(anchor_d[0]) + 2;
    l = max(pcbl + 4, hdp * (ceil(pcbl/hdp)-1) + space);
    if (debug)
        echo(pcbw + space * (pcbl < 3 * space ? 2: 1),
             hdp * ceil(pcbw/hdp) + space);
    w = max(pcbw + space * (pcbl < 3 * space ? 4: 2),
            hdp * ceil(pcbw/hdp) + space);
    h = anchor_h + 0.48;

    function gcd(a,b) = a <= 0 || b <= 0
                        ? min(sign(a), sign(b))
                        : (a % b == 0 ? b : gcd(b,a % b));
    function lcm(a,b) = a * (b / gcd(a, b));

    module anchor(thread=false)
    {
        translate([0, 0, -h-1])
            cylinder(h=h+2, d=5);
        translate([0, 0, -anchor_h])
        {
            if (thread)
            {
                translate([0, 0, anchor_h-0.49])
                    rotate([180, 0, 0])
                        metric_thread(diameter=anchor_d[0], pitch=2.5,
                                      length=anchor_h);
            } else {
                cylinder(h=anchor_h, r1=anchor_d[2]/2, r2=anchor_d[1]/2);
            }
            translate([0, 0, anchor_h-0.5])
                cylinder(h=0.5+0.05, d=anchor_d[0]);
        }

    }

    difference()
    {
        cube([l, w, h]);
        translate([(l-pcbl)/2, (w-pcbw)/2, h-pcb_h])
            cube([pcbl, pcbw, pcbh + 0.02]);

        xholes = floor(l / hdp) + 1;
        yholes = floor(w / hdp) + 1;
        if (debug)
            echo("xholes", xholes, "yholes", yholes);
        for (i = [0:1:2])
        {
            for (j = [0:1:1])
            {
                pos = [i * hdp + space/2,
                       j * w - (j-1) * space/2 - j * space/2,
                       h];
                if (debug)
                    echo(pos);
                translate(pos)
                    anchor(true);
            }
        }

        translate([l/2, w/2, -5])
            cylinder(d=7, h=20);
    }
}

pcb_work_bracket();
