diameter      = 32;
stem_height   = 5.5;
concave_depth = 2.5;


difference() {
  cylinder(h=stem_height, r=6, $fn=100);
  cylinder(h=stem_height, r=5, $fn=100);
};
translate([0,0,stem_height]) {
  difference() {
    cylinder(h=concave_depth, r=diameter/2, $fn=100);
    translate([0,0,1]) {
      cylinder(h=concave_depth, r=(diameter/2)-1, $fn=100);  
    }
  };    
}