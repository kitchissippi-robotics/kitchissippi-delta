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
// Arm_RodEnd.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_Arm_RodEnd();
	Hardware_RodEnd();
} else {
	EnableSupport = false;
}

holderDiameter = hwArmRod_Diameter + rpArmRod_HolderThickness *2;
midPoint = holderDiameter /2;
// ---------------------------------------------------------------------------------------------------------------------

module Part_Arm_RodEnd() {
	difference() {
		union() {
			RodEnd_RodHolder();
			RodEnd_SwivelArm();
			mirror([0,1,0])
				RodEnd_SwivelArm();
		}

		// carve out the arm rod
		translate([0,0, holderDiameter/2])
		rotate([0,90,0])
			cylinder(h = hwArmRod_Length, d = HW_Hole(hwArmRod_Diameter), $fn = gcFacetMedium);

		// carve out the swivel clearance
		hull() {
		translate([-rpRodEnd_SwivelClearance/2 - 2, 0, -2])
		rotate([0,15,0])
		cylinder(h = 20,  d =  rpSwivelArmHeight + 2, $fn = gcFacetMedium);
				// carve out the swivel clearance
		translate([-rpRodEnd_SwivelClearance , 0, -2])
		rotate([0,0,0])
		cylinder(h = 20,  d =  rpSwivelArmHeight + 2, $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 -1, midPoint])
		rotate([-90,90,0])
		cylinder(h = rpSwivelArmHeight + 2, d = 12);
		}

		// carve out the swivel clearance
		hull() {
		translate([-rpRodEnd_SwivelClearance/2 + 2 , 0, -2])
		rotate([0,-15,0])
		cylinder(h = 20,  d =  rpSwivelArmHeight + 2, $fn = gcFacetMedium);

		// carve out the swivel clearance
		translate([-rpRodEnd_SwivelClearance , 0, -2])
		rotate([0,0,0])
		cylinder(h = 20,  d =  rpSwivelArmHeight + 2, $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 -1, midPoint])
		rotate([-90,90,0])
		cylinder(h = rpSwivelArmHeight + 2, d = 12);
		}


	}

}

// ---------------------------------------------------------------------------------------------------------------------

module RodEnd_SwivelArm() {
	hull() {
		// join to the arm
		*translate([-5, -rpSwivelArmHeight/2 - rpArm_PinSeparation, midPoint])
		rotate([90,90,0])
		cylinder(h = 5.25, d = hwPin_Diameter + 6,  $fn = gcFacetMedium);

		// swivel joint pin holder

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 - rpArm_PinSeparation, midPoint])
		rotate([90,90,0])
		cylinder(h = 6, d = hwPin_Diameter + 3,  $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 1.5, midPoint])
		rotate([90,90,0])
		cylinder(h = 3, d = hwPin_Diameter + 6,  $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 3.5, 0])
		cylinder(h = 1, d=hwPin_Diameter, $fn = gcFacetSmall);

		*translate([-5, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 3.5, 0])
		cylinder(h = 1, d=hwPin_Diameter + 2, $fn = gcFacetSmall);

		RodEnd_Joiner();
	}
}

module RodEnd_Joiner() {
	hull() {
		// join to the arm
		translate([-5, -11,midPoint])
		rotate([90,90,0])
		cylinder(h = 1, d = hwPin_Diameter + 6,  $fn = gcFacetMedium);

		translate([-5, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 4, 0])
		cylinder(h = 1, d=hwPin_Diameter, $fn = gcFacetSmall);

		// casing around rod
		translate([0,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth /2, d = holderDiameter , $fn = gcFacetMedium);

		translate([0, -(hwArmRod_Diameter + rpArmRod_HolderThickness)/2, 0])
		cube([rpArmRod_InsertDepth /2, hwArmRod_Diameter + rpArmRod_HolderThickness, 1]);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module RodEnd_RodHolder() {
	RodEnd_Joiner();

	*mirror([0,1,0])
		RodEnd_Joiner();


	hull() {
		// casing around rod
		translate([0,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth, d = holderDiameter , $fn = gcFacetMedium);

		translate([0, -(hwArmRod_Diameter + rpArmRod_HolderThickness)/2, 0])
		cube([rpArmRod_InsertDepth, hwArmRod_Diameter + rpArmRod_HolderThickness, 1]);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module Hardware_RodEnd() {
	translate([0,0, holderDiameter/2])
	rotate([0,90,0])
	%cylinder(h = hwArmRod_Length, d = hwArmRod_Diameter, $fn = gcFacetMedium);

	translate([-rpRodEnd_SwivelClearance, -rpArm_PinSeparation /2, midPoint])
	rotate([90,90,0])
	Draw_Pin();

	translate([-rpRodEnd_SwivelClearance, rpArm_PinSeparation /2, midPoint])
	rotate([-90,90,0])
	Draw_Pin();

	translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2, midPoint])
	rotate([-90,90,0])
	%cylinder(h = rpSwivelArmHeight, d = hwPin_Diameter + 3);
}

// ---------------------------------------------------------------------------------------------------------------------

module Draw_Pin() {
	%cylinder(h = hwPin_Length, d = hwPin_Diameter, $fn=gcFacetSmall);
}
