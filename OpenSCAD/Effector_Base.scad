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
			for (i = [0 : 1 : 2]) {
				rotate([0,0,i * 120])
				 hull() {
					Effector_Base_SwivelArm();
					mirror([1, 0, 0])
						Effector_Base_SwivelArm();
				}
				
			}
			
			hull() {
				for (i = [0 : 1 : 2]) {
				rotate([0,0,i * 120 - 60])
				translate([0, rpEffectorBase_BoltOffset,0])
				Effector_Base_BoltHolder();
				}
			}

		}



		// carveouts
		// carveout central hole

		rotate([0,0,180])
		union() {
			hull() {
				translate([0,0,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);
				translate([0,6,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);
			}

		translate([0,8,-0.1])
			cylinder(h = rpEffectorBase_Thickness + 1, d = 17, $fn = gcFacetLarge);
		
		hull() {
		translate([0,8,4.6])
			cylinder(h = rpEffectorBase_Thickness + 1, d = 17, $fn = gcFacetLarge);

		translate([0,0,4.6])
			cylinder(h = 4.8, d = 16.5, $fn = gcFacetLarge);
		}
		}

		// loop for the sides to effector
		for (i = [0 : 1 : 2]) {
			// carveout pin mounts
			rotate([0,0,i * 120])
			translate([0,rpEffectorBase_SwivelOffset,rpEffectorBase_Thickness/2])
			Effector_Base_MountingPinCarveOut();

			*rotate([0,0,i * 120])
			translate([0,-28,0])
			Effector_Base_SwivelCornerCarveOut();

			rotate([0,0,i * 120])

			Effector_Base_SwivelCarveOut();

			// carveout bolt mounts
			#rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,-0.1])
			cylinder(h = 10, d = 4, $fn = gcFacetSmall);

			if (i == 2) {
			rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,2])
				cylinder(h = 5, d1 = 8.6, d2 = 8.6, $fn = 6);
			}
		}

	}



	rotate([0,0,90])
	translate([16,0,25/2 + 6])
	Draw_25mmFan();

	MultiPartMode = true;
	include <./Vitamins/hotend-jhead.scad>
	include <./Vitamins/hotend-hexagon.scad>

// ~~~ Part No. XC-HA-HOTENDS.COM-01 ~~~ (J-Head from hotends.com)
	*translate([0, 0, -20])
	hotend_jhead();
	
	mirror([0,0,1])
	%translate([0, 0, -51])
	hexagon_hotend();
}

module Effector_Base_Centre() {
	difference() {
	hull() {
			translate([0,0,0])
			cylinder(h = rpEffectorBase_Thickness, d = rpEffectorBase_HotendOpening + 28, $fn = gcFacetLarge);

			translate([0,0,rpEffectorBase_Thickness /4])
			cylinder(h = rpEffectorBase_Thickness /2, d = rpEffectorBase_HotendOpening + 29.5, $fn = gcFacetLarge);
			}

	*translate([0,0,-0.1])
			cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);


	// loop for the sides to effector
		for (i = [0 : 1 : 2]) {


			// carveout bolt mounts
			#rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,-0.1])
			cylinder(h = 10, d = HW_Hole(4), $fn = gcFacetSmall);
		}
	}
}

module Effector_Base_SwivelCarveOut() {
	carveSize = 22;
	hull() {
	rotate([0,0,60])
	translate([0,-22,-0.1])
	scale([1,0.5,1])
			cylinder(h = rpEffectorBase_Thickness + 0.2 + rpEffectorBase_SwivelZOffset, d = carveSize, $fn = gcFacetLarge);

	rotate([0,0,60])
	translate([-carveSize/2,-50,-0.1])
		cube([carveSize, 20, 10]);
	}
}

module Effector_Base_SwivelCornerCarveOut() {
	difference() {
		hull() {
			translate([0,0,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2 + rpEffectorBase_SwivelZOffset, d = 12, $fn = gcFacetLarge);

			rotate([0,0,60])
			translate([0,-20,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2 + rpEffectorBase_SwivelZOffset, d = 12, $fn = gcFacetMedium);

			rotate([0,0,-60])
			translate([0,-20,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2 + rpEffectorBase_SwivelZOffset, d = 12, $fn = gcFacetMedium);

		}
		translate([0, 22- rpEffectorBase_BoltOffset,0])
				Effector_Base_BoltHolder();
	}
}

module Effector_Base_BoltHolder() {

	hull() {
		translate([0,0,0])
			cylinder(h = rpEffectorBase_Thickness, d = 11, $fn = gcFacetMedium);

		translate([0,0, rpEffectorBase_Thickness /4])
			cylinder(h = rpEffectorBase_Thickness /2, d = 12, $fn = gcFacetMedium);

	}

}

// ---------------------------------------------------------------------------------------------------------------------
// one segment of the swivel mounts

module Effector_Base_SwivelArm() {
	hull() {

	translate([-rpArm_Spacing /2 + 11,rpEffectorBase_SwivelOffset,rpEffectorBase_Thickness/2])
	scale([0.9,1,1])
	sphere(d = rpEffectorBase_Thickness, $fn = gcFacetSmall);

	#translate([-rpArm_Spacing /2 + 11, rpEffectorBase_SwivelOffset + 1, 0])
	cylinder(h = 1, d = 3, $fn = gcFacetSmall);

	translate([-rpArm_Spacing /2 + 11,0,rpEffectorBase_Thickness/2])
	scale([0.75,1,1])
	sphere(d = rpEffectorBase_Thickness, $fn = gcFacetSmall);


	translate([-rpArm_Spacing /2 + 11,0,0/2])
	cylinder(h = 1, d = 2, $fn = gcFacetSmall);

	*translate([0,0,0])
			cylinder(h = rpEffectorBase_Thickness, d = rpEffectorBase_HotendOpening + 4, $fn = gcFacetLarge);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// mounting pin carveout

module Effector_Base_MountingPinCarveOut() {
	// Right horizontal pin
		#translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation + 2, 0, 0])
		rotate([0,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Right horizontal pin mounting slot
		hull() {
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation +1, 0, 0 +6])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation - 0, 0, 0 + 2])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// Left horizontal pin
		mirror([1,0,0])
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation + 2, 0, 0])
		rotate([0,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// left horizontal pin mounting slot
		mirror([1,0,0])
			hull() {
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation +1, 0, 0 +6])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation - 0, 0, 0 + 2])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

}

module Draw_25mmFan() {
	edgeCurve = 3;
	fanDepth = 10;
	fanWidth = 25;

	%hull() {
		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = edgeCurve, $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = edgeCurve, $fn = gcFacetSmall);

		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = edgeCurve, $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = edgeCurve, $fn = gcFacetSmall);
	}
}

module Carve_25mmFan() {
	edgeCurve = 3;
	fanDepth = 10;
	fanWidth = 25;

	hull() {
		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve), $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve), $fn = gcFacetSmall);

		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve), $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve), $fn = gcFacetSmall);
	}
}
