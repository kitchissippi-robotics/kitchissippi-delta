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

	color("Grey")
	Part_Effector_Base();
	Hardware_Effector_Base();


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

			difference() {
			hull() {
				for (i = [0 : 1 : 2]) {
				rotate([0,0,i * 120 - 60])
				translate([0, rpEffectorBase_BoltOffset,0])
				Effector_Base_BoltHolder();
				}
				cylinder(h = rpEffectorBase_Thickness - 0.1, d = 35, $fn = gcFacetLarge);
			}

			scale([0.95, 0.95, 1])
			union() {
				for (i = [0 : 1 : 2]) {
				rotate([0,0,i * 120 - 60])
				translate([0, rpEffectorBase_BoltOffset,rpEffectorBase_Thickness -2])
				Effector_Base_BoltHolder();
				}
			}

			}

			Effector_Base_FanMount();

			//Effector_Base_HotendRing();
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
				translate([0,8,4.5])
					cylinder(h = rpEffectorBase_Thickness + 1, d = 17, $fn = gcFacetLarge);

				translate([0,0,4.5])
					cylinder(h = 4.8, d = 17, $fn = gcFacetLarge);
			}

			// carve out for tapered edge
			translate([0,0,5])
					cylinder(h = 4.8, d = 20, $fn = gcFacetLarge);

			translate([0,8,5])
					cylinder(h = 4.8, d = 20, $fn = gcFacetLarge);

			translate([-10, 0, 4.5])
				cube([20, 10, 10]);
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
			rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,-0.1])
			cylinder(h = 10, d = HW_Hole(4), $fn = gcFacetSmall);


			rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,2])
				rotate([0,0,30])
				cylinder(h = 10, d1 = 8.6, d2 = 8.6, $fn = 6);

		}



		rotate([0,0,90])
		translate([rpEffectorBase_FanOffset,0,rpEffectorBase_Thickness + 25/2])
		Carve_25mmFan();

		// fan bolts
		translate([21/2,rpEffectorBase_FanOffset - 15,rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([-90,0,0])
		Carve_hwBolt(hwM3_Bolt_AllenHead, HW_Hole(20), 5);

		translate([-21/2,rpEffectorBase_FanOffset - 15, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([-90,0,0])
		Carve_hwBolt(hwM3_Bolt_AllenHead, HW_Hole(20), 5);

		// m3 nut
		translate([-21/2,rpEffectorBase_FanOffset - 8, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([90,90,0])
			cylinder(h = 3, d1 = 6.6, d2 = 6.6, $fn = 6);

		// m3 nut
		translate([21/2,rpEffectorBase_FanOffset - 8, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([90,90,0])
			cylinder(h = 3, d1 = 6.6, d2 = 6.6, $fn = 6);
	}

	// fancy hole bevels
	difference() {
		union() {
			difference() {
				union() {
					translate([0,0,rpEffectorBase_Thickness - 1.5])
							rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([9.9, 0, 0])
							circle(d = 3);

					translate([0,-8,rpEffectorBase_Thickness - 1.5])
							rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([9.9, 0, 0])
							circle(d = 3);

					Effector_Base_FanMount();
				}

				translate([-11, -8, 4.5])
					cube([22, 8, 10]);
			}

			translate([9.9,0,rpEffectorBase_Thickness - 1.5])
		rotate([90,90,0])
		cylinder(h = 8, d = 3, $fn = gcFacetSmall);

	translate([-9.9,0,rpEffectorBase_Thickness - 1.5])
		rotate([90,90,0])
		cylinder(h = 8, d = 3, $fn = gcFacetSmall);

		}

		hull() {
				translate([0,0,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);
				translate([0,-6,-0.1])
					cylinder(h = rpEffectorBase_Thickness + 0.2, d = rpEffectorBase_HotendOpening, $fn = gcFacetLarge);
			}

			translate([0,-8,-0.1])
				cylinder(h = rpEffectorBase_Thickness + 1, d = 17, $fn = gcFacetLarge);

		hull() {
			translate([0,-8,4.5])
				cylinder(h = rpEffectorBase_Thickness + 1, d = 17, $fn = gcFacetLarge);

			translate([0,0,4.5])
				cylinder(h = 4.8, d = 17, $fn = gcFacetLarge);
		}



		rotate([0,0,90])
			translate([rpEffectorBase_FanOffset,0,rpEffectorBase_Thickness + 25/2])
			Carve_25mmFan();

		// m3 nut
		translate([-21/2,rpEffectorBase_FanOffset - 8, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([90,90,0])
			cylinder(h = 3, d1 = 6.6, d2 = 6.6, $fn = 6);

		// m3 nut
		translate([21/2,rpEffectorBase_FanOffset - 8, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([90,90,0])
			cylinder(h = 3, d1 = 6.6, d2 = 6.6, $fn = 6);

		// fan bolts
		translate([21/2,rpEffectorBase_FanOffset - 15,rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([-90,0,0])
		Carve_hwBolt(hwM3_Bolt_AllenHead, HW_Hole(20), 5);

		translate([-21/2,rpEffectorBase_FanOffset - 15, rpEffectorBase_Thickness + 25/2 - 21/2])
		rotate([-90,0,0])
		Carve_hwBolt(hwM3_Bolt_AllenHead, HW_Hole(20), 5);
	}

}


module Effector_Base_HotendRing() {
	difference() {
		union() {
			translate([0,0,rpEffectorBase_Thickness - 1])
			rotate_extrude(angle = 180, convexity = 2)
			translate([10.5, 0, 0])
			circle(d = 5);

			translate([0,-8,rpEffectorBase_Thickness])
			rotate_extrude(angle = 360, convexity = 2)
			translate([9, 0, 0])
			circle(d = 1);
		}
		// fan airflow zone
		translate([0,rpEffectorBase_FanOffset,rpEffectorBase_Thickness + 25/2])
		rotate([90,0,0])
		cylinder(h = 10, d1 = 25, d2 = 23, $fn = gcFacetLarge);
	}
}
// ---------------------------------------------------------------------------------------------------------------------
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
		*for (i = [0 : 1 : 2]) {


			// carveout bolt mounts
			rotate([0,0,i * 120 - 60])
			translate([0,rpEffectorBase_BoltOffset,-0.1])
			cylinder(h = 10, d = HW_Hole(4.1), $fn = gcFacetSmall);
		}
	}
}

// ---------------------------------------------------------------------------------------------------------------------
module Effector_Base_FanMount() {
	boltHolderDiameter = 7;
	difference() {
		hull() {
			translate([-21/2,rpEffectorBase_FanOffset - 5,rpEffectorBase_Thickness + 25/2 - 21/2])
			rotate([90,0,0])
				cylinder(h = 3, d = boltHolderDiameter, $fn = gcFacetSmall);

			translate([21/2,rpEffectorBase_FanOffset - 5,rpEffectorBase_Thickness + 25/2 - 21/2])
			rotate([90,0,0])
				cylinder(h = 3, d = boltHolderDiameter, $fn = gcFacetSmall);

			translate([-30/2, rpEffectorBase_FanOffset - 8, 0])
				cube([30, 3, rpEffectorBase_Thickness]);
		}
		// fan airflow zone
		translate([0,rpEffectorBase_FanOffset,rpEffectorBase_Thickness + 25/2])
		rotate([90,0,0])
		cylinder(h = 10, d1 = 25, d2 = 23, $fn = gcFacetLarge);
	}

	translate([-21/2,rpEffectorBase_FanOffset - 5,rpEffectorBase_Thickness + 25/2 - 21/2])
	rotate([90,0,0])
		cylinder(h = 3, d = boltHolderDiameter + 0.5, $fn = gcFacetSmall);

	translate([21/2,rpEffectorBase_FanOffset - 5,rpEffectorBase_Thickness + 25/2 - 21/2])
	rotate([90,0,0])
		cylinder(h = 3, d = boltHolderDiameter + 0.5, $fn = gcFacetSmall);
}

// ---------------------------------------------------------------------------------------------------------------------
module Effector_Base_SwivelCarveOut() {
	carveSize = 23;
	hull() {
		rotate([0,0,60])
		translate([0,-25,-0.1])
		scale([1,0.5,1])
				cylinder(h = rpEffectorBase_Thickness + 0.2, d = carveSize, $fn = gcFacetLarge);

		rotate([0,0,60])
		translate([0,-25,-1])
		scale([1,0.8,1])
				cylinder(h = 1, d = carveSize + 1, $fn = gcFacetLarge);

		rotate([0,0,60])
	translate([-(carveSize + 1)/2,-45,-1])
		cube([carveSize + 1, 20, 1]);


rotate([0,0,60])
	translate([-carveSize/2,-45,-0.1])
		cube([carveSize, 20, rpEffectorBase_Thickness + 0.2]);
	}

	hull() {
		rotate([0,0,60])
		translate([0,-25,-0.1])
		scale([1,0.5,1])
				cylinder(h = rpEffectorBase_Thickness + 0.2, d = carveSize, $fn = gcFacetLarge);

		rotate([0,0,60])
		translate([0,-25,rpEffectorBase_Thickness])
		scale([1,0.8,1])
				cylinder(h = 1, d = carveSize + 1, $fn = gcFacetLarge);

		rotate([0,0,60])
	translate([-(carveSize + 1)/2,-45,rpEffectorBase_Thickness])
		cube([carveSize + 1, 20, 1]);

		rotate([0,0,60])
	translate([-carveSize/2,-45,-0.1])
		cube([carveSize, 20, rpEffectorBase_Thickness + 0.2]);
	}

}

// ---------------------------------------------------------------------------------------------------------------------
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

// ---------------------------------------------------------------------------------------------------------------------
module Effector_Base_BoltHolder() {

	hull() {
		translate([0,0,0])
			cylinder(h = rpEffectorBase_Thickness - 1, d1 = 11, d2 = 12, $fn = gcFacetMedium);

		translate([0,0, rpEffectorBase_Thickness /4])
			cylinder(h = rpEffectorBase_Thickness /3, d = 13, $fn = gcFacetMedium);

	}

}

// ---------------------------------------------------------------------------------------------------------------------
// one segment of the swivel mounts

module Effector_Base_SwivelArm() {
	hull() {

		translate([-rpArm_Spacing /2 + 10,rpEffectorBase_SwivelOffset,rpEffectorBase_Thickness/2])
		scale([0.9,1,1])
		sphere(d = rpEffectorBase_Thickness, $fn = gcFacetSmall);

		translate([-rpArm_Spacing /2 + 10, rpEffectorBase_SwivelOffset + 1, 0])
		cylinder(h = 1, d = 3, $fn = gcFacetSmall);

		translate([-rpArm_Spacing /2 + 10,0,rpEffectorBase_Thickness/2])
		scale([0.75,1,1])
		sphere(d = rpEffectorBase_Thickness, $fn = gcFacetSmall);


		translate([-rpArm_Spacing /2 + 10,0,0/2])
		cylinder(h = 1, d = 2, $fn = gcFacetSmall);

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
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, 0 +6])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation - 1, 0, 0 + 2])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

		// Left horizontal pin
		mirror([1,0,0])
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, 0])
		rotate([0,90,0])
			cylinder(h = hwPin_Length + 0.5, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// left horizontal pin mounting slot
		mirror([1,0,0])
		hull() {
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, 0 +6])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
			translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation - 1, 0, 0 + 2])
			rotate([0,105,0])
				cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);
		}

	translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation + 4, 0, 0])
	rotate([0,90,0])
	cylinder(h = 1, d1 = 20, d2 = 19);

	mirror([1,0,0])
	translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation + 4, 0, 0])
	rotate([0,90,0])
	cylinder(h = 1, d1 = 20, d2 = 19);
}

// ---------------------------------------------------------------------------------------------------------------------

module Hardware_Effector_Base() {
		MultiPartMode = true;
	include <./Vitamins/hotend-jhead.scad>
	include <./Vitamins/hotend-hexagon.scad>

// ~~~ Part No. XC-HA-HOTENDS.COM-01 ~~~ (J-Head from hotends.com)
	*translate([0, 0, -5])
	hotend_jhead();

	mirror([0,0,1])
	%translate([0, 0, -51])
	hexagon_hotend();

	rotate([0,0,90])
	translate([rpEffectorBase_FanOffset,0,rpEffectorBase_Thickness + 25/2 ])
		Draw_25mmFan();

	// m3 bolt
	translate([-21/2,rpEffectorBase_FanOffset - 15, rpEffectorBase_Thickness + 25/2 - 21/2])
	rotate([-90,0,0])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 20);



	// m3 bolt
	translate([21/2,rpEffectorBase_FanOffset - 15,rpEffectorBase_Thickness + 25/2 - 21/2])
	rotate([-90,0,0])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

	include <Effector_LockRing.scad>

	color("Lime")
	translate([0,0,0])
	mirror([0,0,1])
	Part_Effector_LockRing();
}

// ---------------------------------------------------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------------------------------------------------

module Carve_25mmFan() {
	edgeCurve = 3;
	fanDepth = 10;
	fanWidth = 25;

	hull() {
		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve) + 0.5, $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), fanWidth/2 - edgeCurve/2])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve) + 0.5, $fn = gcFacetSmall);

		translate([-fanDepth/2, fanWidth/2 - edgeCurve/2, -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve) + 0.5, $fn = gcFacetSmall);

		translate([-fanDepth/2, -(fanWidth/2 - edgeCurve/2), -(fanWidth/2 - edgeCurve/2)])
		rotate([0,90,0])
		cylinder(h = fanDepth, d = HW_Hole(edgeCurve) + 0.5, $fn = gcFacetSmall);
	}
}
