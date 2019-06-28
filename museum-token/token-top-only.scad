diameter      = 32;
stem_height   = 1;
concave_depth = 2.5;

difference() {
difference() {
    cylinder(h=concave_depth, r=diameter/2, $fn=100);
    translate([0,0,1]) {
      cylinder(h=concave_depth, r=(diameter/2)-1, $fn=100);  
    }
  };    

translate([0,0,-.25]){
difference() {
  cylinder(h=stem_height, r=6, $fn=100);
  cylinder(h=stem_height, r=4.75, $fn=100);
};
}
}