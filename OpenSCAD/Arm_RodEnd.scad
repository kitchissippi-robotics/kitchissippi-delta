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
	//Hardware_RodEnd();
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

		// carve out glue & air pressure relieve channel for when the rod is installed

		translate([-0.1,0,midPoint])
		rotate([0,90,0])
		cylinder(h = 2, d1 = 1, d2 = 2, $fn = gcFacetSmall);

		translate([0.1,0,midPoint])
		rotate([0,-90,0])
		cylinder(h = 2, d1 = 1, d2 = 2, $fn = gcFacetSmall);



		// carve out the arm rod
		translate([1, 0, holderDiameter/2])
		rotate([0,90,0])
			cylinder(h = hwArmRod_Length, d = HW_Hole(hwArmRod_Diameter) + 0.25, $fn = gcFacetMedium);

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

		// carve out pin
		translate([-rpRodEnd_SwivelClearance, -rpArm_PinSeparation /2, midPoint])
		rotate([90,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// carve out pin slot
		hull() {
		translate([-rpRodEnd_SwivelClearance, -rpArm_PinSeparation /2, midPoint + 6])
		rotate([105,0,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		translate([-rpRodEnd_SwivelClearance, -rpArm_PinSeparation /2 +1, midPoint + 2])
		rotate([105,0,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// carve out pin
		translate([-rpRodEnd_SwivelClearance, rpArm_PinSeparation /2, midPoint])
		rotate([-90,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// carve out pin slot
		hull() {
		translate([-rpRodEnd_SwivelClearance, rpArm_PinSeparation /2, midPoint + 6])
		rotate([-105,0,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		translate([-rpRodEnd_SwivelClearance, rpArm_PinSeparation /2 -1, midPoint + 2])
		rotate([-105,0,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}



	}

}

// ---------------------------------------------------------------------------------------------------------------------

module RodEnd_SwivelArm() {
	squishEndScale = 0.9;

	hull() {

		// swivel joint pin holder

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 - rpArm_PinSeparation, midPoint])
		rotate([90,90,0])
		scale([1,squishEndScale,1])
		cylinder(h = 4, d = hwPin_Diameter + 3,  $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 1, midPoint])
		rotate([90,90,0])
		scale([1,squishEndScale,1])
		cylinder(h = 2, d = hwPin_Diameter + 6,  $fn = gcFacetMedium);

		translate([-rpRodEnd_SwivelClearance -1, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 1.5, 0])
		cylinder(h = 1, d=3, $fn = gcFacetSmall);

		RodEnd_Joiner();
	}

}

module RodEnd_Joiner() {
	union() {
		// join to the arm
		translate([-5, -9,midPoint])
		rotate([90,90,0])
		scale([1, 1, 0.5])
		sphere(d = 10, $fn = gcFacetMedium);
		//cylinder(h = 1, d1 = hwPin_Diameter + 5, d2 = hwPin_Diameter +3,  $fn = gcFacetMedium);

		translate([-5, -rpSwivelArmHeight/2 - rpArm_PinSeparation - 2, 0])
		cylinder(h = 1, d=3, $fn = gcFacetSmall);

		// casing around rod
		translate([0,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth /2 -2, d = holderDiameter - 1, $fn = gcFacetMedium);

		translate([0, -(hwArmRod_Diameter -1)/2, 0])
		cube([rpArmRod_InsertDepth /2 -2, hwArmRod_Diameter -1, 1]);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// A small channel to allow glue and air to escape when the rod is pressed into the part
// .....................................................................................................................

module RodEnd_ReliefChannel() {

}

// ---------------------------------------------------------------------------------------------------------------------

module RodEnd_RodHolder() {
	RodEnd_Joiner();

	*mirror([0,1,0])
		RodEnd_Joiner();


	hull() {
		// casing around rod
		translate([1,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = 1, d1 = holderDiameter -2, d2 = holderDiameter, $fn = gcFacetMedium);

		translate([2,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth -3, d1 = holderDiameter, d2 = holderDiameter -1, $fn = gcFacetMedium);

		translate([0, -(hwArmRod_Diameter -1)/2, 0])
		cube([rpArmRod_InsertDepth/2, hwArmRod_Diameter -1, 1]);

		translate([rpArmRod_InsertDepth - 1.5, 0, 0])
		cylinder(h = 1, d = hwArmRod_Diameter -2, $fn = gcFacetSmall);
		//cube([rpArmRod_InsertDepth, hwArmRod_Diameter -3, 1]);

		translate([1,0, holderDiameter/2])
		rotate([0,90,0])
		cylinder(h = rpArmRod_InsertDepth, d = holderDiameter- 2, $fn = gcFacetMedium);
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
