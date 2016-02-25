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
// Effector_Base.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_Effector_Base();
	//Hardware_Effector_Base();
} else {
	EnableSupport = false;
}

// ---------------------------------------------------------------------------------------------------------------------

module Part_Effector_Base() {
	difference() {
		union() {
			// loop for the sides to effector
			for (i = [0 : 1 : 3]) {
				rotate([0,0,i * 120])
				union() {
					Effector_Base_SwivelArm();
					mirror([1,0,0])
						Effector_Base_SwivelArm();
				}
			}
		}

		// carveouts
		// carveout central hole
		translate([0,0,-0.1])
			cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);

		// loop for the sides to effector
		for (i = [0 : 1 : 3]) {
			// carveout pin mounts
			rotate([0,0,i * 120])
			translate([0,rpEffectorBase_SwivelOffset,rpEffectorBase_Thickness/2])
			Effector_Base_MountingPinCarveOut();

			// carveout bolt mounts
			rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,-0.1])
			cylinder(h = 10, d = 4, $fn = gcFacetSmall);
		}
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// one segment of the swivel mounts

module Effector_Base_SwivelArm() {
	hull() {
	translate([-rpArm_Spacing /2 + 9,rpEffectorBase_SwivelOffset,rpEffectorBase_Thickness/2])
	rotate([0,90,0])
	cylinder(h = 6, d = rpEffectorBase_Thickness);

	translate([0,0,0])
			cylinder(h = rpEffectorBase_Thickness, d = rpEffectorBase_HotendOpening + 4, $fn = gcFacetLarge);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// mounting pin carveout

module Effector_Base_MountingPinCarveOut() {
	// Right horizontal pin
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, 0])
		rotate([0,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Right horizontal pin mounting slot
		hull() {
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation , 0, 0 +6])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation -1, 0, 0 + 2])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// Left horizontal pin
		translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, 0])
		rotate([0,-90,0])
			cylinder(h = hwPin_Length + 1, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// left horizontal pin mounting slot
		mirror([1,0,0]) hull() {
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation , 0, 0 +6])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation -1, 0, 0 + 2])
		rotate([0,105,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

}
