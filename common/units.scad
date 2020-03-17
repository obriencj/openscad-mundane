/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3

  Unit conversion stuff
*/


function inch_to_mm(x) = x * 25.4;
function vec_inch_to_mm(v) = [for(x=v) inch_to_mm(x)];

function mm_to_inch(x) = x / 25.4;
function vec_mm_to_inch(v) = [for(x=v) mm_to_inch(x)];


// The end.
