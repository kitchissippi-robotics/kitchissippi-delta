// *********************************************************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *********************************************************************************************************************
// Kitchissippi Delta 3D Printer - Prototype
//
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2014-2016 Kitchissippi Robotics
// ---------------------------------------------------------------------------------------------------------------------
// LinearCarriage_Common.scad
// Does not generate a part, just common functions used within the LinearCarriage component
// *********************************************************************************************************************

include <LinearCarriage_Common.scad>

// ---------------------------------------------------------------------------------------------------------------------
module LC_BearingPost (nutSide = false) {

	// base
	LC_BearingPostBase();

	translate([0,0,4.2]) {
		cylinder(r1 = 8, r = hw608InnerRingRadius, h = 1);
	}

	// bearing holder
	difference() {
		translate([0,0,5.2]) {
			cylinder(r=hw608BoreRadius, h= 7);

		}
		translate([0,0,5.2]) {
			cylinder(r=hwBoltRadius, h =7.2);
		}
	}

	// spacer ridge
	difference() {
		translate([0,0,12.2]) {
			cylinder(r=hw608BoreRadius - 0.5, h= 1.5);

		}
		translate([0,0,12.2]) {
			cylinder(r=hwBoltRadius, h =1.5);
		}
	}

} // module

module LC_BearingPostBase() {
translate([0, 0, 0])
		cylinder(h = 2, d1 = 15, d2 = 16);

	translate([0, 0, 2])
		cylinder(h = 2, d1 = 16, d2 = 16);

	translate([0, 0, 4])
		cylinder(h = 2, d1 = 16, d2 = 15);
}
