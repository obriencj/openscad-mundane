/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/
use <../common/math.scad>

module copy_mirror(plane=[0, 0, 1]) {
     children();
     mirror(plane) children();
}


module copy_translate(x=0, y=0, z=0, copies=1) {
     if(copies) {
	  for(i = [0:copies]) {
	       translate([x * i, y * i, z * i]) {
		    children();
	       };
	  };
     } else {
	  children();
     };
}


module copy_rotate(x=0, y=0, z=0, copies=1) {
     if(copies) {
	  for(i = [0:copies]) {
	       rotate([x * i, y * i, z * i]) {
		    children();
	       };
	  };
     } else {
	  children();
     };
}


module copy_grid(offsets=[0, 0, 0], grid=[1, 1, 1]) {
     copy_translate(x=offsets.x, copies=grid.x-1) {
	  copy_translate(y=offsets.y, copies=grid.y-1) {
	       copy_translate(z=offsets.z, copies=grid.z-1) {
		    children();
	       };
	  };
     };
}


module duplicate(move_v=[0,0,0], rotate_v=[0,0,0]) {
     children();
     translate(move_v) {
	  rotate(rotate_v) {
	       children();
	  };
     };
}


//
// isomers() builds stereoisometric copies, horrifyingly laid out on the xy
// plane.
//
// you can specify how many copies with n=<NUMBER> or ns[xN, yN, zN],
// n=1 is the same as ns=[1, 0, 0]
// If the single n is nonzero, it is used, else the vector is.
//
// This is astonishingly close to actual n-dimensional chess.  You probably
// only want to choose n>1 on 2 or fewer planes at the same time. Inputs:
//
// contributed by @vathpela
//
module isomers(n=0, ns=[1, 0, 0], size=[1, 1, 1], debug=false)
{
    nm = [n ? n : ns[0], n ? 1 : ns[1], n ? 1 : ns[2]];

    xn = max(nm[0], 1);
    yn = max(nm[1], 1);
    zn = max(nm[2], 1);
    if (debug)
        echo("[xn,yn,zn]", [xn,yn,zn]);
    m = logn(xn*yn*zn, 2);

    xs = size[0];
    ys = size[1];
    zs = size[2];
    if (debug)
        echo("[xs,ys,zs]", [xs,ys,zs]);

    module zmirrorshift(origin=[0, 0, 0], x, y)
    {
        if (debug)
            echo("zmirror origin", origin);
        for (z = [0:1:zn-1])
        {
            shift0 = [origin[0] + xs/2 * 1.2 * (z-0.5)*-zn,
                      origin[1],
                      origin[2] + zs];
            shift1 = [origin[0] + xs/2 * 1.2 * (z-3.5)*zn - (xn) * xs * 1.2,
                      origin[1],
                      origin[2]];
            shift2 = [origin[0] + xs/2 * 1.2 * (z-0.5)*-zn,
                      origin[1],
                      origin[2]];

            if (z % 2 == 0 && zn != 1) {
                if (debug)
                    echo("za [z]", [z], "[zs]", [zs], "t([x,y,z])", shift0);
                translate(shift0) mirror([0, 0, 1]) children();
            } else {
                if (debug)
                    echo("zb [z]", [z], "[zs]", [zs], "t([x,y,z])", shift1);
                translate(zn == 1 ? shift2 : shift1) children();
            }
        }
    }

    module ymirrorshift(origin=[0, 0, 0], x)
    {
        if (debug)
            echo("ymirror origin", origin);
        for (y = [0:1:yn-1])
        {
            shift=[origin[0],
                   origin[1] + y * ys * 1.2,
                   origin[2]];
            if (debug)
                echo("ya [x,y,z]", [x,y,0], "[ys,zs]", [ys,zs], "t([x,y,z])", shift);
            if (y % 2 == 0) {
                zmirrorshift(shift, x, y) mirror([0, 1, 0]) children();
            } else {
                zmirrorshift(shift, x, y) children();
            }
        }
    }

    module xmirrorshift(origin=[0, 0, 0])
    {
        if (debug)
            echo("xmirror origin", origin);
        for (x = [0:1:xn-1])
        {
            shift=[origin[0] + x * xs * 1.2,
                   origin[1],
                   origin[2]];
            if (debug)
                echo("xa [x,y,z]", [x,0,0],
                     "[xs,ys,zs]", [xs,ys,zs],
                     "t([x,y,z])", shift);
            if (x % 2 == 0) {
                ymirrorshift(shift, x) mirror([1, 0, 0]) children();
            } else {
                ymirrorshift(shift, x) children();
            }
        }
    }

    xmirrorshift() children();
}

// The end.
