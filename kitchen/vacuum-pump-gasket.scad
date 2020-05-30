//
// vacuum_pump_gasket is a gasket to make a Vacu Vin Wine Saver Pump[0],
// which is entirely hard injection molded plastic and expects a rubber
// stopper value to be on top of a wine bottle, interface better with with
// Ziploc Vacuum Pump bags[1], which have hard acrylic sheet valves
// expecting to be used with a motorized pump with rubber gaskets.  The
// motorized pump is completely overkill for removing ~10cc of air from a
// plastic bag, the hand pump works very well and doesn't take up valuable
// real-estate on the kitchen counter.
//
// to be printed with something like FilaFlex40 or NinjaFlex 85A, or
// something even softer if you have it.
//
// [0] https://www.amazon.com/Original-Vacu-Vin-Vacuum-Stoppers/dp/B000GA3KCE
// [1] https://www.amazon.com/Ziploc-Vacuum-Pump-Refill-Quart/dp/B0145O2AC2/
//
// contributed by @vathpela
//


id = 26.75;
od0 = 35.5;
od1h = 2.5;
od1 = 40;
od2h = 6;
od2 = 39.5;
od3h = 7.5;
od3 = 35.75;

module vacuum_pump_gasket(id=id, od0=od0, od1h=od1h, od1=od1,
                          od2h=od2h, od2=od2, od3h=od3h, od3=od3,
                          $fn=200)
{
    t = 1;

    points = [[id/2-t, 0],
              [id/2-t, od1h],
              [id/2, od1h],
              [id/2, t],
              [od0/2, t],
              [od1/2, od1h],
              [od2/2, od2h],
              [od3/2, od3h],
              [od3/2+t, od3h],
              [od2/2+t, od2h],
              [od1/2+t, od1h],
              [od0/2+t, 0],
              ];
    rotate_extrude()
        polygon(points);
}

vacuum_pump_gasket();
