//
// just some useful general math utilities
//

//
// min() and max() give you the lower or higher of their arguments,
// respectively.  They behave asymmetrically at 0, so as to establish a
// stable sort order, merely reversed, no matter which order the inputs come
// in.
//
// contributed by @vathpela
//
function min(x, y) = y > x ? x : y;
function max(x, y) = x >= y ? x : y;

//
// logx(x, b) is log base x of b aka logX(b)
//
// *sigh*, openscad's math primitives are so defective
//
// contributed by @vathpela
//
function logx(x, b) = log(x) / log(b);


