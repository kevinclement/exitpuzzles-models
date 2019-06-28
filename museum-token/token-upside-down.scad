diameter    = 32;
stem_height = 5.5;
top_height  = 2;

cylinder(h=top_height, r=diameter/2, $fn=100);
translate([0,0,top_height]) {
  difference() {
    cylinder(h=stem_height, r=6, $fn=100);
    cylinder(h=stem_height, r=5, $fn=100);
  };
}

