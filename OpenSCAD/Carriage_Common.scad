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

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

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

module hw_SteelTube(length = 100) {
	edgeBevel = 1.5	;
	tubeWidth = 19.1;

	%linear_extrude(height = length, centre = true)
	hull() {
		translate([tubeWidth / 2 - edgeBevel / 2, tubeWidth / 2 - edgeBevel / 2, 0])
		circle(edgeBevel, $fn = gcFacetSmall);

		translate([-(tubeWidth / 2 - edgeBevel / 2), tubeWidth / 2 - edgeBevel / 2, 0])
		circle(edgeBevel, $fn = gcFacetSmall);

		translate([tubeWidth / 2 - edgeBevel / 2, -(tubeWidth / 2 - edgeBevel / 2), 0])
		circle(edgeBevel, $fn = gcFacetSmall);

		translate([-(tubeWidth / 2 - edgeBevel / 2), -(tubeWidth / 2 - edgeBevel / 2), 0])
		circle(edgeBevel, $fn = gcFacetSmall);
	}

}

translate([0,0,-50])
rotate([0,0,45])
hw_SteelTube();

hwSpacerThickess = 4.4;
rpBearing_DefaultSpacing = 24 * 2;
rpBearing_UpperOffset = 15;
rpBearing_LowerOffset = 20;

translate([0,0,rpBearing_UpperOffset])
hw_BearingCluster(4.4);

translate([0,0,-rpBearing_LowerOffset])
hw_BearingCluster(7.6);

module hw_BearingCluster(_spacerThickness, compressionFactor = 0.1) {
	spacerThickness = _spacerThickness - compressionFactor;

translate([-hw608Thickness /2 - spacerThickness /2, rpBearing_DefaultSpacing / 2 - spacerThickness /2, 0])
import("Vitamins/608_bearing.stl");
translate([-hw608Thickness /2 - spacerThickness /2, -rpBearing_DefaultSpacing / 2 + spacerThickness /2, 0])
import("Vitamins/608_bearing.stl");

translate([hw608Thickness /2 + spacerThickness /2, rpBearing_DefaultSpacing / 2 - spacerThickness /2, 0])
import("Vitamins/608_bearing.stl");
translate([hw608Thickness /2 + spacerThickness /2, -rpBearing_DefaultSpacing / 2 + spacerThickness /2, 0])
import("Vitamins/608_bearing.stl");
}

/*
hw608Thickness = 7;
hw608OutsideDiameter = 21.8;
hw608InsideDiameter = 8;
hw608HubDiameter = 12;
*/
