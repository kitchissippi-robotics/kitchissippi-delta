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
// Effector_LockRing.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>
include <Writescad/Write.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;

	//color("Lime")
	Part_Effector_LockRing();
} else {
	EnableSupport = false;
}



// ---------------------------------------------------------------------------------------------------------------------

module Part_Effector_LockRing() {
	ringDiameter = hwGrooveMount_HeadDiameter + 5;
	thumbScrewClearance = 18;

	difference() {
		union() {
			for (i = [0 : 1 : 2]) {
				hull() {
					rotate([0,0,i * 120 - 60])
					translate([0, rpEffectorBase_BoltOffset,0])
					cylinder(h = hwGrooveMount_HeadThickness, d1 = 10, d2 = 9, $fn = gcFacetMedium);

					cylinder(h = hwGrooveMount_HeadThickness + 2,d = 11, $fn = gcFacetMedium);

					cylinder(h = hwGrooveMount_HeadThickness + 3,d = 9, $fn = gcFacetMedium);
				}

				// twist handles
				hull() {
					rotate([0,0,i * 120 - 60])
					translate([0, rpEffectorBase_BoltOffset /2 + 1,4])
					cylinder(h = hwGrooveMount_HeadThickness, d = 3, $fn = gcFacetSmall);

					translate([0,0,11])
					sphere(d = 3, $fn = gcFacetSmall);
				}
			}
			hull() {
				translate([0,0,0])
				cylinder(h = hwGrooveMount_HeadThickness + 2, d = ringDiameter - 1, $fn = gcFacetLarge);
				translate([0,0, 0])
				cylinder(h = hwGrooveMount_HeadThickness /2, d = ringDiameter, $fn = gcFacetLarge);

				translate([0,0, 6])
				cylinder(h = hwGrooveMount_HeadThickness /2, d = ringDiameter /2, $fn = gcFacetLarge);

				*translate([0,0,hwGrooveMount_HeadThickness])
					sphere(d = ringDiameter, $fn = gcFacetMedium);
			}

			cylinder(h = 11, d = 13, $fn = gcFacetMedium);
			translate([0,0,11])
			rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([5, 0, 0])
							circle(d = 3);
		}

		// carve out

		cylinder(h = 20, d = HW_Hole(4), $fn = gcFacetSmall);

		for (i = [0 : 1 : 2]) {

			for (j = [0 : 1 : 10]) {
			rotate([0,0,i * 120 - 60 - j])
			translate([0, rpEffectorBase_BoltOffset,-4])
			cylinder(h = hwGrooveMount_HeadThickness + 5, d = HW_Hole(4), $fn = gcFacetSmall);
			}

			rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,hwGrooveMount_HeadThickness])
			cylinder(h = hwGrooveMount_HeadThickness + 5, d = thumbScrewClearance - 3.1, $fn = gcFacetMedium);

		}


		for (i = [0 : 1 : 2]) {
		rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,hwGrooveMount_HeadThickness + 2])
		rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([thumbScrewClearance /2 - 1.5, 0, 0])
							circle(d = 4);
		}

		// pushfit
		translate([0,0,hwGrooveMount_HeadThickness + 2])
			cylinder(h = 6.5, d = 9, $fn = gcFacetMedium);

		translate([0,0,-0.1])
		cylinder(h = hwGrooveMount_HeadThickness + 0.2, d = hwGrooveMount_HeadDiameter + .25, $fn = gcFacetLarge);

		// carve off bottom
		translate([-50,-50,-100])
		cube([100, 100, 100]);

		// carve off top
		translate([-50,-50,13])
		cube([100, 100, 100]);

	}

	*for (i = [0 : 1 : 2]) {
		rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,hwGrooveMount_HeadThickness])
		rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([thumbScrewClearance /2 - 6, 0, 0])
							circle(d = 2);
		}
}
