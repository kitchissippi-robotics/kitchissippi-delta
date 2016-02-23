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

// ---------------------------------------------------------------------------------------------------------------------

module Part_Arm_RodEnd() {
	RodEnd_RodHolder();


}

// ---------------------------------------------------------------------------------------------------------------------

module RodEnd_RodHolder() {
	holderDiameter = hwArmRod_Diameter + rpArmRod_HolderThickness *2;

	hull() {
		translate([0,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth, d = holderDiameter , $fn = gcFacetMedium);

		translate([0, -(hwArmRod_Diameter + rpArmRod_HolderThickness)/2, 0])
		cube([rpArmRod_InsertDepth, hwArmRod_Diameter + rpArmRod_HolderThickness, 1]);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module Hardware_RodEnd() {
}
