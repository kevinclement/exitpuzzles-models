cylinder(h=2.5, r=15, $fn=100);
translate([0,0,2.5]) {
  difference() {
    cylinder(h=5.5, r=6, $fn=100);
    cylinder(h=4.5, r=5, $fn=100);
  };
};

