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

	*translate([0,0,rpLC_CarriageThickness])
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
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.5, $fn = gcFacetSmall);

			translate([-upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.5, $fn = gcFacetSmall);

			// ---- lower posts for bearings
			translate([lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.5, $fn = gcFacetSmall);

			translate([-lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2])
				cylinder(h = hw608Thickness, d = hw608InsideDiameter - 0.5, $fn = gcFacetSmall);

			hull() {
			_LC_PostBases();
			}

			_LC_BearingHubs();

		}

		_LC_BoltCarveOuts();

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

		// steel frame/linear guide tube clearance
		translate([0,0,rpLC_CarriageThickness])
		rotate([90,0,0])
		translate([0,0,-50 ])
		rotate([0,0,45])
			Carve_hw_SteelTube();

		// curved carve out at sides

		sideCurveSize = 50;
		sideCurveOffset = 38;
		sideCurveRotate = 10;

		translate([sideCurveOffset,0,0.9])
		rotate([0,0,sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 3.1, d1 = sideCurveSize - 2, d2 = sideCurveSize -2, $fn = gcFacetLarge);

		translate([sideCurveOffset,0,-0.1])
		rotate([0,0,sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 1.1, d1 = sideCurveSize, d2 = sideCurveSize - 2, $fn = gcFacetLarge);

		translate([sideCurveOffset,0, 3.7])
		rotate([0,0,sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 4, d1 =sideCurveSize - 2, d2 = sideCurveSize + 2, $fn = gcFacetLarge);


		translate([-sideCurveOffset,0,0.9])
		rotate([0,0,-sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 3.1, d1 = sideCurveSize - 2, d2 = sideCurveSize -2, $fn = gcFacetLarge);

		translate([-sideCurveOffset,0,-0.1])
		rotate([0,0,-sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 1.1, d1 = sideCurveSize, d2 = sideCurveSize - 2, $fn = gcFacetLarge);

		translate([-sideCurveOffset,0, 3.7])
		rotate([0,0,-sideCurveRotate])
		scale([0.5,1,1])
		cylinder(h = 4, d1 =sideCurveSize - 2, d2 = sideCurveSize + 2, $fn = gcFacetLarge);

		// curved carve out at bottom

		bottomCurveSize = 50;
		bottomCurveOffset = rpBearing_LowerOffset + 14;

		translate([0,bottomCurveOffset,-0.1])
		scale([1,0.5,1])
		cylinder(h = 1.1, d1 = bottomCurveSize, d2 = bottomCurveSize - 2, $fn = gcFacetLarge);

		translate([0,bottomCurveOffset,0.9])
		scale([1,0.5,1])
		cylinder(h = 3.1, d1 = bottomCurveSize - 2, d2 = bottomCurveSize -2, $fn = gcFacetLarge);

		translate([0,bottomCurveOffset, 3.7])
		scale([1,0.5,1])
		cylinder(h = 3, d1 =bottomCurveSize - 2, d2 = bottomCurveSize + 2, $fn = gcFacetLarge);

		// adjuster nut
		translate([0, -rpCarriageAdapter_AdjustmentNutOffset - 0, -rpCarriageAdapter_AdjustmentBoltOffset])
		rotate([90,90,0])
			cylinder(h = 4, d = 11, $fn = 6);

		// adjuster washer
		translate([0, -rpCarriageAdapter_AdjustmentNutOffset - 7.25, -rpCarriageAdapter_AdjustmentBoltOffset])
		rotate([90,90,0])
			cylinder(h = 2, d = 12.25, $fn = gcFacetSmall);
	}

	_LC_PostBases(false);

	difference() {
		_LC_BearingHubs();
		_LC_BoltCarveOuts();
	}
}

module _LC_BoltCarveOuts(_carveBolts = true) {
	if (true == _carveBolts) {
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

	}

		// washer carveouts
		translate([upperXOffset/2, -rpBearing_UpperOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius + 0.25, $fn = gcFacetSmall);

		translate([-upperXOffset/2, -rpBearing_UpperOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius + 0.25, $fn = gcFacetSmall);

		translate([lowerXOffset/2, rpBearing_LowerOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius + 0.25, $fn = gcFacetSmall);

		translate([-lowerXOffset/2, rpBearing_LowerOffset, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius + 0.25, $fn = gcFacetSmall);
}

module _LC_BearingHubs() {
	translate([upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d2 = hw608HubDiameter, d1 = hw608HubDiameter + 4, $fn = gcFacetMedium);

	translate([-upperXOffset/2, -rpBearing_UpperOffset, rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d2 = hw608HubDiameter, d1 = hw608HubDiameter + 4, $fn = gcFacetMedium);

	translate([lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d2 = hw608HubDiameter, d1 = hw608HubDiameter + 4, $fn = gcFacetMedium);

	translate([-lowerXOffset/2, rpBearing_LowerOffset, rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness])
				cylinder(h = hubThickness, d2 = hw608HubDiameter, d1 = hw608HubDiameter + 4, $fn = gcFacetMedium);
}

module _LC_PostBases(_carveBolts = true) {
	difference() {
		union() {
			translate([-upperXOffset/2, -rpBearing_UpperOffset, 0])
			hull() {
				cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetMedium);
				translate([0,0, 1])
					cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetMedium);
			}

			translate([upperXOffset/2, -rpBearing_UpperOffset, 0])
			hull() {
				cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetMedium);
				translate([0,0, 1])
					cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwUpperBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetMedium);
			}

			translate([-lowerXOffset/2, rpBearing_LowerOffset, 0])
			hull() {
				cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetMedium);
				translate([0,0, 1])
					cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetMedium);
			}

			translate([lowerXOffset/2, rpBearing_LowerOffset, 0])
			hull() {
				cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness, d = hwWasherRadius * 2 + 4, $fn = gcFacetMedium);
				translate([0,0, 1])
					cylinder(h = rpLC_CarriageThickness - hw608Thickness - hwLowerBearingSpacerWidth/2 - hubThickness - 2, d = hwWasherRadius * 2 + 5, $fn = gcFacetMedium);
			}
		}

		_LC_BoltCarveOuts(_carveBolts);
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
