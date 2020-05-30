//
// find the distance from the center of a chord with length c to the center of the circle
// it intersects
//
// c = length of a chord through a circle
// h = height from center of chord to the tangential point on the circle
//     the tangential point on the circle
//
// see https://en.wikipedia.org/wiki/Circular_segment for math
//
// contributed by @vathpela
//
function segment_depth(h, c) = (h/2) + (pow(c,2)/(8*h)) - h;

//
// radius of a circle given a chord through it
//
// c = length of a chord through a circle
// h = height from center of chord to the tangential point on the circle the
//     tangential point on the circle
//
// contributed by @vathpela
//
function circle_r_from_chord(h, c) = h + segment_depth(h, c);

//
// the distance formula for 2d space
//
// contributed by @vathpela
//
function distance(xy0, xy1) = sqrt(pow((xy1[0] - xy0[0]), 2)
                                   + pow((xy1[1] - xy1[1]), 2));

//
// the mean of two points in 2d space
//
// contributed by @vathpela
//
function center(xy0, xy1) = [(xy1[0]+xy0[0])/2, (xy1[1]+xy0[1])/2];
