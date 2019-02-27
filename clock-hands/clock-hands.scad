use <../SatisfyingGears1.6.scad>;

//PairGears(AngularResolution=5,M=10000,slices=5,TeethA=12,TeethB=20,BacklashA=0,BacklashB=0,PressureAngle=20,DiametralPitch=.6,ToothPhaseA=0,Thickness=5,HelixFaceAngle=15,Layers=1,AltLayerToothPhase=0,ChamferThickness=1,InnerChamfers=true,Rescale=1,AddendumA=0,AddendumB=0,GearAExists=true,GearBExists=true,GearBCentered=false,GearAGhost=false,GearBGhost=false,debug=false);


quality = 37; //"Roundness" of circles.
hour_height = 10;
minute_height = 30;
gear_height = 5;
gear_gap = 4;
gear_teeth = 12;

$fa = 50;

//MinuteHand();
//HourHand();
//MinuteStepper();
TopFrame();
mirror() TopFrame();

variance = .9;
module TopFrame() {
  difference() {
    //minkowski()
    {
      union() {
        cube([50 + variance, 20, 3]);
        difference() {
          translate([50 + variance,0,0]) cube([5,20,15]);
          translate([50 + variance-2.5,0,3]) cube([5,20,15]);
        }
      }
      //cylinder(r=1,h=1,$fn=quality);
    }
    translate([10,10,-10]) cylinder(r=3.2, h=20, $fn=quality);
    translate([30,10,-10]) cylinder(r=2.7, h=20, $fn=quality);
  }
  
}

module MinuteHand() {   
  union()
  {
    PairGears(TeethA=gear_teeth,TeethB=gear_teeth,Thickness=gear_height,GearBExists=false);
    translate([0,0,gear_gap/2]) cylinder(r=3, h=gear_gap, $fn=quality);
    //cylinder(r=1.35, h=minute_height - 9, $fn=quality);
    //translate([0,0,minute_height-7]) cube([2.4, 2.4, 4], center=true);
    translate([0,0,minute_height/2]) cube([2.4, 2.4, minute_height], center=true);
  }
}

module MinuteStepper() {
     
  difference() {
    PairGears(TeethA=gear_teeth,TeethB=gear_teeth,Thickness=gear_height,GearAExists=false,GearBCentered=true);
    difference() {
      translate([0,0,-gear_height/2]) cylinder(r=2.6,h=gear_height, $fn=quality);
      translate([-5,-7,-gear_height/2]) cube([10,5,gear_height]);
    }
  }

}
 
module HourHand() {
   difference()
   {
     union()
     {
       PairGears(TeethA=gear_teeth,TeethB=gear_teeth,Thickness=gear_height,GearBExists=false);
       translate([0,0,0]) cylinder(r=2.25, h=hour_height + gear_height, $fn=quality);
     }
     
     translate([0,0,-10]) cylinder(r=1.7, h=hour_height + gear_height + 20, $fn=quality);        
   }
 }
 
 module HourGear() {
   
 }
 