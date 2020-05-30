tape_length = 25.4 * 3;
tape_width = 19.05;
tape_thickness = 0.2;

//
// This builds flat tape.
//
// This is useful for reassembling thin-walled objects that are too big to
// print, and thus have been cut in half to print.  Basically put the tape
// in place and hit it with a heat gun, or if you used ABS, brush it with
// acetate.
//
// by default it's 3" x 0.75" x 0.2mm, with the expectation of being printed
// at 0.2mm layer height (i.e. only the first layer)
//
// contributed by @vathpela
//
module tape(length=tape_length, width=tape_width, height=tape_thickness)
{
    cube([width, length, height]);
}

tape();
