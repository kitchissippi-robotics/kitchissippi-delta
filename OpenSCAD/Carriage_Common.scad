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
module LC_BearingPost (nutSide = false, postHeight = 16) {

	// base
	LC_BearingPostBase();

	translate([0,0,4.2]) {
		cylinder(h = postHeight, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);
	}


	// bearing holder
	*difference() {
		translate([0,0,5.2]) {
			cylinder(r=hw608BoreRadius, h= 7);

		}
		translate([0,0,5.2]) {
			cylinder(r=hwBoltRadius, h =7.2);
		}
	}

	// spacer ridge
	*difference() {
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

module Carve_hw_SteelTube(length = 100) {
	edgeBevel = 2	;
	tubeWidth = 20;

	linear_extrude(height = length, centre = true)
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

// Figure out the horizontal offset between bearings in a cluster based on the spacer size and estimated compression

function HW_BearingOffset(spacerThickness) = (48 - (spacerThickness - hwSpacerCompressionFactor));

// Figure out the spacing between bearings in a cluster based on the horizontal offset
function HW_BearingSpacing(bearingOffset) = (48 - bearingOffset + hwSpacerCompressionFactor);

module Draw_BearingCluster(spacerThickness) {
	yOffset = HW_BearingOffset(spacerThickness);

	%translate([-hw608Thickness /2 - spacerThickness /2, yOffset /2, 0])
		import("Vitamins/608_bearing.stl");

	%translate([-hw608Thickness /2 - spacerThickness /2, -yOffset /2, 0])
		import("Vitamins/608_bearing.stl");

	%translate([hw608Thickness /2 + spacerThickness /2, yOffset /2, 0])
		import("Vitamins/608_bearing.stl");

	%translate([hw608Thickness /2 + spacerThickness /2, -yOffset /2, 0])
		import("Vitamins/608_bearing.stl");
}

/*
hw608Thickness = 7;
hw608OutsideDiameter = 21.8;
hw608InsideDiameter = 8;
hw608HubDiameter = 12;
*/
