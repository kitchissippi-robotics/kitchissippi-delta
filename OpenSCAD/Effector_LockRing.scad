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

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;

	color("Lime")
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

					translate([0,0,0])
					cylinder(h = hwGrooveMount_HeadThickness + 2,d = 11, $fn = gcFacetMedium);
				}

				hull() {
					rotate([0,0,i * 120 - 60])
					translate([0, rpEffectorBase_BoltOffset,0])
					cylinder(h = hwGrooveMount_HeadThickness, d1 = 8, $fn = gcFacetMedium);

					translate([0,0,10])
					sphere(d = 6, $fn = gcFacetMedium);
				}
			}
			hull() {
				translate([0,0,0])
				cylinder(h = hwGrooveMount_HeadThickness + 2, d = ringDiameter - 1, $fn = gcFacetLarge);
				translate([0,0, hwGrooveMount_HeadThickness /4])
				cylinder(h = hwGrooveMount_HeadThickness /2, d = ringDiameter, $fn = gcFacetLarge);

				translate([0,0,hwGrooveMount_HeadThickness /2])
					sphere(d = ringDiameter, $fn = gcFacetMedium);
			}
		}

		// carve out
		for (i = [0 : 1 : 2]) {

			rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,-4])
			cylinder(h = hwGrooveMount_HeadThickness + 5, d = HW_Hole(4), $fn = gcFacetMedium);

			rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,hwGrooveMount_HeadThickness])
			cylinder(h = hwGrooveMount_HeadThickness + 5, d = thumbScrewClearance, $fn = gcFacetMedium);

		}

		// pushfit
		translate([0,0,hwGrooveMount_HeadThickness + 2])
			cylinder(h = 10, d = 9, $fn = gcFacetMedium);

		translate([0,0,-0.1])
		cylinder(h = hwGrooveMount_HeadThickness + 0.2, d = hwGrooveMount_HeadDiameter + .25, $fn = gcFacetLarge);

		// carve off bottom
		translate([-50,-50,-100])
		cube([100, 100, 100]);

		// carve off top
		translate([-50,-50,11])
		cube([100, 100, 100]);

	}
}
