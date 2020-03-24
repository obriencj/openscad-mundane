
// c = length of a chord through a circle
// h = height from center of chord to the tangential point on the circle
// segment_depth == distance from the center of the chord to the center of the
//                  circle
// see https://en.wikipedia.org/wiki/Circular_segment for math
function segment_depth(h, c) = (h/2) + (pow(c,2)/(8*h)) - h;
function circle_r_from_chord(h, c) = h + segment_depth(h, c);

