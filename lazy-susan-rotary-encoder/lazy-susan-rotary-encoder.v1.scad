/* 
  Lazy Susan Rotary Encoder mount:
  
  Mount for lazy susan with a rotary encoder slot in the middle to allow for detection of rotation.
  
  [Design borrowed heavily from Phat Justice]  
*/

doProj                  = false;   // Do 2D projection to allow to print
quality                 = 36;      // "Roundness" of circles.

// Thicknesss
OuterThickness          = 2;       // Thickness of outer stuff
InnerThickness          = 5;       // Thickness of inner stuff
WallThickness           = 2;       // Thickness of the wall

// Spokes
spokes                   = 4;
SpokeDiameter            = 4.15;

// ## TOP SETTINGS ########################
TopPillarDimension       = 6.9;
TopPillarHeight          = 5;
TopPillarDistance        = 150;    // measured edge to edge

// Screw holes
TopScrewHoleDimension    = 2;

TopCenterBoreDiameter    = 116;    // That huge hole in the middle of the bearing
TopArmLength             = sqrt(2 * (TopPillarDistance/2 * TopPillarDistance/2));
TopArmWidth              = 13.28;

// ## BOTTOM SETTINGS ########################
BottomCenterBoreDiameter = 113;    // That huge hole in the middle of the bearing

// Bottom screw holes
BottomHoleDimension      = 5;
BottomHoleDistance       = 129;    // measured edge to edge

// Center hole
BottomCenterHoleDiameter = 7.5;

// Arms
BottomArmLength          = sqrt(2 * (BottomHoleDistance/2 * BottomHoleDistance/2));
BottomArmWidth           = 13.28;

if (doProj) {
  projection() bottom_plate();
}
else {
  bottom_plate();
}

module top_plate()  {
  render() {
    difference()
    {
      union()
      {
        // Center of the adapter plate
        cylinder(r=TopCenterBoreDiameter/2 + WallThickness, h=InnerThickness, $fn=quality);
        
        // Arms
        for (i = [0:4])
        {
          rotate([0,0,45+i*90])
          {
            translate([-((TopArmWidth/2) + WallThickness),0,0]) //The base arm
              cube([TopArmWidth + (WallThickness * 2), TopArmLength, WallThickness]);
           }
        }
        
        // Pillars
        for (i = [0:3])
        {
          rotate ( [0,0,45+(i*90)] )
          {
            translate ( [0, TopArmLength - 5.25, 0] )
            {
              cylinder ( r=TopPillarDimension/2, h=TopPillarHeight, $fn=quality );
            }
          }
        }
      }
      
      // NOW TO REMOVE STUFFFFFF...
      if (doProj) {
        // Make the pillars wholes so it can be 2D printed
        for (i = [0:3])
        {
          rotate ( [0,0,45+(i*90)] )
          {
            //Screw Holes to mount plate to bearing
            translate ( [0, TopArmLength - 5.25, 0] )
            {
              cylinder ( r=TopPillarDimension/2, h=OuterThickness, $fn=quality );
            }
          }
        }
      }
      
      // Screw holes
      for (i = [0:3])
      {
        rotate ( [0,0,45+(i*90)] )
        {
          translate ( [-7, TopArmLength - 12.25, 0] )
          {
            cylinder ( r=TopScrewHoleDimension/2, h=TopPillarHeight, $fn=quality );
          }
        }
      }
      
      // Hollow out the center to save plastic!
      difference()
      {
        // This is the big hole
        cylinder(r=(TopCenterBoreDiameter/2)-WallThickness, h=TopPillarHeight); 
        union()
        {
          for (i=[0:(spokes-1)])
          {
            difference()
            {
              rotate ([0,0,i*(360/spokes)])
              {
                // making tapered spokes
                hull()
                {
                  cylinder(r=SpokeDiameter + WallThickness, h=TopPillarHeight, $fn=quality);
                  translate([(TopCenterBoreDiameter/2)+(WallThickness)-SpokeDiameter,0,0])
                  {
                      cylinder(r=SpokeDiameter, h=TopPillarHeight, $fn=quality);
                  }
                }
              }
              difference() {
                cylinder(r=3.2,h=TopPillarHeight);
                translate([-5,-6.5-.2,0]) cube([10,5,10-2]);//the center screw hole
              }
            }
          }
        }
      }
    }
  }
}

module bottom_plate()  {
  render() {
    translate([0,175,0]) {
    difference()
    {
      union()
      {
        // Center of the bottom plate
        cylinder(r=BottomCenterBoreDiameter/2 + WallThickness, h=InnerThickness, $fn=quality);
        
        // Arms
        for (i = [0:4])
        {
          rotate([0,0,45+i*90])
          {
            translate([-((BottomArmWidth/2) + WallThickness),0,0]) //The base arm
              cube([BottomArmWidth + (WallThickness * 2), BottomArmLength, WallThickness]);
          }
        }       
      }
          
      // NOW TO REMOVE STUFFFFFF...

      // The four holes
      for (i = [0:3])
      {
        rotate ( [0,0,45+(i*90)] )
        {
          translate ( [0, BottomArmLength - 5.25, 0] )
          {
            cylinder ( r=BottomHoleDimension/2, h=OuterThickness, $fn=quality );
          }
        }
      }
      
      //Hollow out the center to save plastic!
      difference()
      {
        // This is the big hole
        cylinder(r=(BottomCenterBoreDiameter/2)-WallThickness, h=InnerThickness); 
        union()
        {
          for (i=[0:(spokes-1)])
          {
            difference()
            {
              rotate ([0,0,i*(360/spokes)])
              {
                // making tapered spokes
                hull() 
                {
                  cylinder(r=SpokeDiameter + WallThickness, h=InnerThickness, $fn=quality);
                  translate([(BottomCenterBoreDiameter/2)+(WallThickness)-SpokeDiameter,0,0])
                  {
                    cylinder(r=SpokeDiameter, h=InnerThickness, $fn=quality);
                  }
                }
              }
              difference() {
                cylinder(r=BottomCenterHoleDiameter/2, h=InnerThickness);
              }
            }
          }
        }
      }
    }
  }}
}

