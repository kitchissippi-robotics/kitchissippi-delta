// *********************************************************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *********************************************************************************************************************
// Kitchissippi Delta 3D Printer - Prototype
//
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// ---------------------------------------------------------------------------------------------------------------------
// CarriageAdapter.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

MultiPartMode = true;
include <Pin_Swivel_Arm.scad>
MultiPartMode = false;

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

%translate([0,-1, 0])
import("../YellowCarriage.stl", convexity=3);

if (undef == MultiPartMode || MultiPartMode == false) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_CarriageAdapter();
	Hardware_CarriageAdapter();

	// test render the swivel arm
	translate([0, -rpArm_PinDepth -rpArm_PinSeparation/2, rpCarriageAdapter_SwivelOffset])
	rotate([-90,0,0])
	{
		Part_Pin_Swivel_Arm();
		Hardware_Pin_Swivel_Arm();
	}

} else {
	EnableSupport = false;
}

module Part_CarriageAdapter() {
	difference() {
		// main shape
		union() {
			CarriageAdapter_Base();

			hull() {
				// washer base
				translate([0, -rpCarriageAdapter_AdjustmentWasherOffset + 2.5, rpCarriageAdapter_AdjustmentBoltOffset])
				rotate([90,90,0])
					cylinder(h = 2.5, d = 12, $fn = gcFacetMedium);

				// adjuster nut base
				translate([0, -rpCarriageAdapter_AdjustmentNutOffset + 0.5, rpCarriageAdapter_AdjustmentBoltOffset])
				rotate([90,90,0])
					cylinder(h = 5, d = 14, $fn = 6);

				// adjuster bolt cover
				translate([0, 20, rpCarriageAdapter_AdjustmentBoltOffset])
				rotate([90,90,0])
					cylinder(h = 20, d = 8, $fn = gcFacetMedium);
			}
		}

		// carve outs

		// base block carveout
		translate([-50, -50, -20])
			cube([100, 100, 20]);
	}
}

module CarriageAdapter_Base() {
	difference() {
		hull() {
			// bolt bases
			translate([-rpCarriageAdapter_MountSpacing /2,0, 0])
				cylinder(h = rpCarriageAdapter_BaseBoltThickness, d = 10, $fn = gcFacetMedium);

			translate([rpCarriageAdapter_MountSpacing /2,0, 0])
				cylinder(h = rpCarriageAdapter_BaseBoltThickness, d = 10, $fn = gcFacetMedium);

			// four corners
			translate([rpCarriageAdapter_BaseWidth /2, rpCarriageAdapter_BaseLength /2, 0])
				cylinder(h = rpCarriageAdapter_BaseThickness, d = 4, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_BaseWidth /2, -rpCarriageAdapter_BaseLength /2, 0])
				cylinder(h = rpCarriageAdapter_BaseThickness, d = 4, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BaseWidth /2, rpCarriageAdapter_BaseLength /2, 0])
				cylinder(h = rpCarriageAdapter_BaseThickness, d = 4, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BaseWidth /2, -rpCarriageAdapter_BaseLength /2, 0])
				cylinder(h = rpCarriageAdapter_BaseThickness, d = 4, $fn = gcFacetSmall);
		}

		// carve out belt path
		beltPathSize = 2;

		hull() {
			translate([rpCarriageAdapter_BeltPathOffset + rpCarriageAdapter_BeltPathWidth - beltPathSize, rpCarriageAdapter_BaseLength /2 + 8, rpCarriageAdapter_BaseThickness])
			rotate([90,0,0])
				cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_BeltPathOffset + rpCarriageAdapter_BeltPathWidth - beltPathSize, rpCarriageAdapter_BaseLength /2 + 8, 10])
			rotate([90,0,0])
				cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BeltPathOffset - rpCarriageAdapter_BeltPathWidth + beltPathSize, rpCarriageAdapter_BaseLength /2 + 8, rpCarriageAdapter_BaseThickness])
			rotate([90,0,0])
				cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BeltPathOffset - rpCarriageAdapter_BeltPathWidth + beltPathSize, rpCarriageAdapter_BaseLength /2 + 8, 10])
			rotate([90,0,0])
				cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);
		}
	}
}

module Hardware_CarriageAdapter() {
	// mounting bolts
	translate([-rpCarriageAdapter_MountSpacing /2,0, -12 + rpCarriageAdapter_BaseBoltThickness])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 12);

	translate([rpCarriageAdapter_MountSpacing /2,0, -12 + rpCarriageAdapter_BaseBoltThickness])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 12);

	// adjuster bolt
	translate([0, 0, rpCarriageAdapter_AdjustmentBoltOffset])
	rotate([90,0,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 24);

	// adjuster nut
	translate([0, -rpCarriageAdapter_AdjustmentNutOffset - 0.5, rpCarriageAdapter_AdjustmentBoltOffset])
	rotate([90,90,0])
		%cylinder(h = 3, d = 10, $fn = 6);

	// adjuster washer
	translate([0, -rpCarriageAdapter_AdjustmentWasherOffset, rpCarriageAdapter_AdjustmentBoltOffset])
	rotate([90,0,0])
		%cylinder(h = 1, d = 11.5, $fn = gcFacetMedium);
}