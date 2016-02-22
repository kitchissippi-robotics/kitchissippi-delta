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

MultiPartMode = false;
include <Pin_Swivel_Arm.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

*translate([0,-1, 0])
import("../YellowCarriage.stl", convexity=3);

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;
}

if (MultiPartMode == false) {
	Part_CarriageAdapter();
	Hardware_CarriageAdapter();

	// test render the swivel arm
	%translate([0, -rpArm_PinDepth -rpArm_PinSeparation/2, rpCarriageAdapter_SwivelOffset])
	rotate([-90,0,0])
	{
		Part_Pin_Swivel_Arm();
		Hardware_Pin_Swivel_Arm();
	}
} else {
	EnableSupport = false;
}

// ---------------------------------------------------------------------------------------------------------------------

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
					cylinder(h = 5, d = 15, $fn = 6);

				// adjuster bolt cover
				translate([0, -12, rpCarriageAdapter_AdjustmentBoltOffset])
				rotate([90,90,0])
					cylinder(h = 2, d = 8, $fn = gcFacetMedium);
			}

			hull() {
				// adjuster bolt cover
				translate([0, 2.5, rpCarriageAdapter_AdjustmentBoltOffset])
				rotate([90,90,0])
					cylinder(h = 15, d = 8, $fn = gcFacetMedium);

				// adjuster bolt cover
				/*translate([0, 14, 2])
				rotate([90,90,0])
					cylinder(h = 30, d = 8, $fn = gcFacetMedium);

				// adjuster bolt cover
				translate([0, 16, 2])
				rotate([90,90,0])
					cylinder(h = 30, d = 6, $fn = gcFacetMedium);

				// adjuster bolt cover
				translate([0, 20, 0])
				rotate([90,90,0])
					cylinder(h = 30, d = 2, $fn = gcFacetMedium);*/

				translate([0, 10, 2])
					sphere(d = 6, $fn = gcFacetSmall);
			}

			translate([-rpCarriageAdapter_BeltPathOffset,8,0])
			CarriageBase_BeltClamp(12);

			translate([-rpCarriageAdapter_BeltPathOffset,-20,0])
			CarriageBase_BeltClamp(12);
			//CarriageAdapter_SwivelArm();
		}

		// carve outs
		translate([-rpCarriageAdapter_BeltPathOffset,8,0])
			CarriageBase_BeltCarveOut(12);

				translate([-rpCarriageAdapter_BeltPathOffset,-20,0])
			CarriageBase_BeltCarveOut(12);

		// swivel surface carveout
		translate([rpArm_Spacing /2 -8,0, rpCarriageAdapter_SwivelOffset])
		rotate([0,90,0])
			cylinder(h = 5, d = 12, $fn=gcFacetSmall);

		mirror([1,0,0])
		translate([rpArm_Spacing /2 -8,0, rpCarriageAdapter_SwivelOffset])
		rotate([0,90,0])
			cylinder(h = 5, d = 12, $fn=gcFacetSmall);

		// Right horizontal pin
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, rpCarriageAdapter_SwivelOffset])
		rotate([0,90,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Right horizontal pin mounting slot
		hull() {
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation , 0, rpCarriageAdapter_SwivelOffset +6])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation -1, 0, rpCarriageAdapter_SwivelOffset + 2])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// Left horizontal pin
		translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, rpCarriageAdapter_SwivelOffset])
		rotate([0,-90,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// left horizontal pin mounting slot
		mirror([1,0,0]) hull() {
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation , 0, rpCarriageAdapter_SwivelOffset +6])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation -1, 0, rpCarriageAdapter_SwivelOffset + 2])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// adjuster bolt
		translate([0, 0, rpCarriageAdapter_AdjustmentBoltOffset])
		rotate([90,0,0])
			Carve_hwBolt(hwNo8_Bolt_PanHead, 30);

		// mounting bolts

		translate([-rpCarriageAdapter_MountSpacing /2,0, -12 + rpCarriageAdapter_BaseBoltThickness])
				Carve_hwBolt(hwNo8_Bolt_PanHead, 12);

		translate([rpCarriageAdapter_MountSpacing /2,0, -12 + rpCarriageAdapter_BaseBoltThickness])
				Carve_hwBolt(hwNo8_Bolt_PanHead, 12);

		hull() {
			translate([-rpCarriageAdapter_MountSpacing /2,0, 5])
				cylinder(h = 2.5, d = 9, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_MountSpacing /2,0, 5])
				cylinder(h = 5, d = 8, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_MountSpacing /2,0, 10])
				sphere(d = 8, $fn = gcFacetSmall);
		}

		hull() {
			translate([rpCarriageAdapter_MountSpacing /2,0, 5])
				cylinder(h = 2.5, d = 9, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_MountSpacing /2,0, 5])
				cylinder(h = 5, d = 8, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_MountSpacing /2,0, 10])
				sphere(d = 8, $fn = gcFacetSmall);
		}

		// adjuster nut
		translate([0, -rpCarriageAdapter_AdjustmentNutOffset - 0, rpCarriageAdapter_AdjustmentBoltOffset])
		rotate([90,90,0])
			cylinder(h = 4, d = 11, $fn = 6);

		// base block carveout
		translate([-50, -50, -20])
			cube([100, 100, 20]);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module CarriageBase_BeltCarveOut(length) {
	height = 10.1 - rpCarriageAdapter_BaseThickness;
		translate([1, -0.1, rpCarriageAdapter_BaseThickness])
			cube([1, length + 0.2, height]);

		translate([-2, -0.1, rpCarriageAdapter_BaseThickness])
			cube([1, length + 0.2, height]);

		for (i = [0 : 2 : length]) {
			translate([2, i, rpCarriageAdapter_BaseThickness])
			scale([2.5,1,1])
			cylinder(h = height, d = 1, $fn = gcFacetSmall);

			translate([-2, i, rpCarriageAdapter_BaseThickness])
			scale([2.5,1,1])
			cylinder(h = height, d = 1, $fn = gcFacetSmall);
		}
}

// ---------------------------------------------------------------------------------------------------------------------

module CarriageBase_BeltClamp(length) {
		hull() {
			// --
			translate([rpCarriageAdapter_BeltPathWidth/2, length -1, 0])
			scale([2,1,1])
				cylinder( h = 2, d = 2, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_BeltPathWidth/2, length -1, 8])
				sphere(d = 2, $fn = gcFacetSmall);

			// --
			translate([-rpCarriageAdapter_BeltPathWidth/2, length -1, 0])
			scale([2,1,1])
				cylinder( h = 2, d = 2, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BeltPathWidth/2, length -1, 8])
				sphere(d = 2, $fn = gcFacetSmall);

			// --
			translate([rpCarriageAdapter_BeltPathWidth/2, 1, 0])
			scale([2,1,1])
				cylinder( h = 2, d = 2, $fn = gcFacetSmall);

			translate([rpCarriageAdapter_BeltPathWidth/2, 1, 8])
				sphere(d = 2, $fn = gcFacetSmall);

			// --
			translate([-rpCarriageAdapter_BeltPathWidth/2, 1, 0])
			scale([2,1,1])
				cylinder( h = 2, d = 2, $fn = gcFacetSmall);

			translate([-rpCarriageAdapter_BeltPathWidth/2, 1, 8])
				sphere(d = 2, $fn = gcFacetSmall);
		}

}

// ---------------------------------------------------------------------------------------------------------------------

module CarriageAdapter_Base() {
	difference() {
		union() {
			hull() {
				// bolt bases
				translate([-rpCarriageAdapter_MountSpacing /2,0, 0])
					cylinder(h = rpCarriageAdapter_BaseBoltThickness, d = 8, $fn = gcFacetMedium);

				translate([rpCarriageAdapter_MountSpacing /2,0, 0])
					cylinder(h = rpCarriageAdapter_BaseBoltThickness, d = 8, $fn = gcFacetMedium);

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

			CarriageAdapter_SwivelArm();
			mirror([1,0,0])
				CarriageAdapter_SwivelArm();
		}

		CarriageAdapter_BeltPathCarveout();
		mirror([1,0,0])
			CarriageAdapter_BeltPathCarveout();

	}
}

// ---------------------------------------------------------------------------------------------------------------------

module CarriageAdapter_SwivelArm() {
	sphereSize = 6;
	inset = (50 - rpArm_Spacing) /2;
	hull() {
		// bottom point
		translate([rpCarriageAdapter_BaseWidth /2 -1, rpCarriageAdapter_BaseLength /2 -1, 0])
		sphere(d = sphereSize,  $fn = gcFacetSmall);

		// top point
		translate([rpCarriageAdapter_BaseWidth /2 -1, -rpCarriageAdapter_BaseLength /2 +1, 0])
		sphere(d = sphereSize,  $fn = gcFacetSmall);

		// lower point
		translate([rpCarriageAdapter_BaseWidth /2 -3, 0, 2])
		rotate([90, 0, 90])
		cylinder(h = 4, d = 18, $fn = gcFacetMedium);
	}

	hull() {
		// top point
		translate([rpCarriageAdapter_BaseWidth /2 - 1, -rpCarriageAdapter_BaseLength /2 +1, 0])
		sphere(d = sphereSize,  $fn = gcFacetSmall);


		// smaller swivel mount point
		translate([rpCarriageAdapter_BaseWidth /2 -3 - inset, 0, rpCarriageAdapter_SwivelOffset])
			rotate([90, 0, 90])
			cylinder(h = 4, d = 5, $fn = gcFacetMedium);

		// larger swivel mount point
		translate([rpCarriageAdapter_BaseWidth /2 -2 - inset, 0, rpCarriageAdapter_SwivelOffset])
			rotate([90, 0, 90])
			cylinder(h = 2, d = 6, $fn = gcFacetMedium);


		// lower point
		translate([rpCarriageAdapter_BaseWidth /2 -3, 0, 2])
		rotate([90, 0, 90])
		cylinder(h = 4, d = 8, $fn = gcFacetMedium);
	}

}

// ---------------------------------------------------------------------------------------------------------------------

module CarriageAdapter_BeltPathCarveout() {
	// carve out belt path
	beltPathSize = 4;
	inset = (50 - rpArm_Spacing) /2;
	hull() {
		translate([rpCarriageAdapter_BeltPathOffset + rpCarriageAdapter_BeltPathWidth/2 - beltPathSize /2, rpCarriageAdapter_BaseLength /2 + 8, rpCarriageAdapter_BaseThickness + beltPathSize /2])
		rotate([90,0,0])
			cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

		translate([0, rpCarriageAdapter_BaseLength /2 + 8, 10])
		rotate([90,0,0])
			cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

		translate([rpCarriageAdapter_BeltPathOffset - rpCarriageAdapter_BeltPathWidth/2 + beltPathSize /2, rpCarriageAdapter_BaseLength /2 + 8, rpCarriageAdapter_BaseThickness + beltPathSize /2])
		rotate([90,0,0])
			cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

		translate([rpCarriageAdapter_BeltPathOffset + rpCarriageAdapter_BeltPathWidth - beltPathSize *2 - inset, rpCarriageAdapter_BaseLength /2 + 8, 15])
		rotate([90,0,0])
			cylinder(h = rpCarriageAdapter_BaseLength + 16, d = beltPathSize, $fn = gcFacetSmall);

	}
}

// ---------------------------------------------------------------------------------------------------------------------

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
