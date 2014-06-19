// Kitchessippi 03.02 Prototype
// Created by Brian Cantin 2014

include <dimensions.scad>

module cBearingPost (x, y, z) {

	translate([x,y,z]) {
	
		// base
		difference() {
			union() {
				cylinder(r = 8, r1 = 7, h = 1, $fn = RENDER_RESOLUTION);
				translate([0,0,1]) {
					cylinder(r=8, h = 3.2, $fn = RENDER_RESOLUTION);
				}
			} 
			
			cylinder(r = hwWasherRadius, h = 4.2, $fn = RENDER_RESOLUTION);		// cutout for the washer/bolt
		} // difference
		
		translate([0,0,4.2]) {
			cylinder(r1 = 8, r = hw608InnerRingRadius, h = 1, $fn = RENDER_RESOLUTION);
		}
			
		// bearing holder
		difference() {
			translate([0,0,5.2]) {
				cylinder(r=hw608BoreRadius, h= 7, $fn = RENDER_RESOLUTION);
				
			}
			translate([0,0,5.0]) {
				cylinder(r=hwBoltRadius, h =7.2, $fn = RENDER_RESOLUTION);
			}
		}
		
		// spacer ridge
		difference() {
			translate([0,0,12.2]) {
				cylinder(r=hw608BoreRadius - 0.5, h= 1.5, $fn = RENDER_RESOLUTION);
				
			}
			translate([0,0,12.2]) {
				cylinder(r=hwBoltRadius, h =1.5, $fn = RENDER_RESOLUTION);
			}
		}
		
		
		
	} // translate
} // module

doublePostSpacing = 40;

// test joiner bit
difference() {
	translate([doublePostSpacing / 2, 0, 0.5]) {
		cube(size=[doublePostSpacing, 15.2, 1], center = true);
	}
	cylinder(r = hwWasherRadius, h = 4.2, $fn = RENDER_RESOLUTION);		// cutout for the washer/bolt
	translate([doublePostSpacing, 0, 0]) {
		cylinder(r = hwWasherRadius, h = 4.2, $fn = RENDER_RESOLUTION);		// cutout for the washer/bolt
	}
}

translate([doublePostSpacing /2 , 6.75, 2]) {
	cube(size=[doublePostSpacing, 1.7, 4], center = true);
}

translate([doublePostSpacing /2 , -6.75, 2]) {
	cube(size=[doublePostSpacing, 1.7, 4], center = true);
}

cBearingPost (0,0,0);
cBearingPost (doublePostSpacing,0,0);

