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
// LinearCarriage_Inner.scad
// *********************************************************************************************************************

include <Dimensions.scad>
include <Carriage_Common.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_LC_Inner();

	translate([0,0,rpLC_CarriageThickness])
	Draw_LC_Inner_Hardware();
} else {
	EnableSupport = false;
}

upperXOffset = HW_BearingOffset(hwUpperBearingSpacerWidth);
lowerXOffset = HW_BearingOffset(hwLowerBearingSpacerWidth);

hubThickness = 2;

// *********************************************************************************************************************

module Part_LC_Inner() {








	difference() {
		union() {
				// ---- upper posts for bearings
			translate([upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);
			translate([upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d = hw608HubDiameter, $fn = gcFacetSmall);




			translate([-upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);
			translate([-upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d = hw608HubDiameter, $fn = gcFacetSmall);



			// ---- lower posts for bearings
			translate([lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);
			translate([lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d = hw608HubDiameter, $fn = gcFacetSmall);

			translate([-lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);
			translate([-lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d = hw608HubDiameter, $fn = gcFacetSmall);


			hull() {
			_LC_PostBases();
			}
		}

		// -- upper bolt carveouts
		translate([upperXOffset/2, -rpBearing_UpperOffset, 30 + 3.25])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		translate([-upperXOffset/2, -rpBearing_UpperOffset, 30 + 3.25])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		// -- lower bolt carveouts
		translate([lowerXOffset/2, rpBearing_LowerOffset, 30 + 3.25])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		translate([-lowerXOffset/2, rpBearing_LowerOffset, 30 + 3.25])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);



		// washer carveouts
		translate([upperXOffset/2, -rpBearing_UpperOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius, $fn = gcFacetSmall);

		translate([-upperXOffset/2, -rpBearing_UpperOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius, $fn = gcFacetSmall);

		translate([lowerXOffset/2, rpBearing_LowerOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius, $fn = gcFacetSmall);

		translate([-lowerXOffset/2, rpBearing_LowerOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius, $fn = gcFacetSmall);

		// adapter mounting bolts

		translate([rpCarriageAdapter_MountSpacing/2, 0, 30])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		translate([-rpCarriageAdapter_MountSpacing/2, 0, 30])
		rotate([0,180,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		// adapter mounting nuts

		translate([rpCarriageAdapter_MountSpacing/2, 0, 3])

			cylinder(h = 10, d = HW_Hole(hwNutRadius * 2), $fn = 6);

		translate([-rpCarriageAdapter_MountSpacing/2, 0, 3])

			cylinder(h = 10, d = HW_Hole(hwNutRadius * 2), $fn = 6);



		// steel frame/linear guide tube
	translate([0,0,rpLC_CarriageThickness])
	rotate([90,0,0])
	translate([0,0,-50 ])
	rotate([0,0,45])
		Carve_hw_SteelTube();

	}
}

module _LC_PostBases() {
	translate([-upperXOffset/2, -rpBearing_UpperOffset, 0])
	hull() {
		cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetSmall);
		translate([0,0, 1])
			cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetSmall);
	}

	translate([upperXOffset/2, -rpBearing_UpperOffset, 0])
	hull() {
		cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetSmall);
		translate([0,0, 1])
			cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetSmall);
	}

	translate([-lowerXOffset/2, rpBearing_LowerOffset, 0])
	hull() {
		cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetSmall);
		translate([0,0, 1])
			cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetSmall);
	}

	translate([lowerXOffset/2, rpBearing_LowerOffset, 0])
	hull() {
		cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetSmall);
		translate([0,0, 1])
			cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetSmall);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module _LC_Inner_Base() {
	*hull() {
		translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();
	}
}

module Draw_LC_Inner_Hardware() {
	// steel frame/linear guide tube
	rotate([90,0,0])
	translate([0,0,-50])
	rotate([0,0,45])
		hw_SteelTube();

	// upper bearing cluster
	rotate([90,90,0])
	translate([0,0,rpBearing_UpperOffset])
		Draw_BearingCluster(hwUpperBearingSpacerWidth);

	// lower bearing cluster
	rotate([90,90,0])
	translate([0,0,-rpBearing_LowerOffset])
		Draw_BearingCluster(hwLowerBearingSpacerWidth);

		// -- upper bolts
	#translate([upperXOffset/2, -rpBearing_UpperOffset, 30 + 3.25 - rpLC_CarriageThickness])
	rotate([0,180,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 30);

	#translate([-upperXOffset/2, -rpBearing_UpperOffset, 30 + 3.25 - rpLC_CarriageThickness])
	rotate([0,180,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 30);

	// -- lower bolts
	#translate([lowerXOffset/2, rpBearing_LowerOffset, 30 + 3.25 - rpLC_CarriageThickness])
	rotate([0,180,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 30);

	#translate([-lowerXOffset/2, rpBearing_LowerOffset, 30 + 3.25 - rpLC_CarriageThickness])
	rotate([0,180,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 30);

}
