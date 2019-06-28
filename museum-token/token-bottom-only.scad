diameter      = 32;
stem_height   = 6;
concave_depth = 2.5;

difference() {
  cylinder(h=stem_height, r=6, $fn=100);
  cylinder(h=stem_height, r=5, $fn=100);
};
