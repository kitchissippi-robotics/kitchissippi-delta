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

	*rotate([0,-90,0])
	linear_extrude(height = 1, center = false, convexity = 2)
				LockRing_Profile();

	*rotate_extrude(convexity = 2, $fn = gcFacetLarge)
	rotate([0,0,90])
		LockRing_Profile();
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
					cylinder(h = hwGrooveMount_HeadThickness, d1 = 12, d2 = 10, $fn = gcFacetMedium);

					cylinder(h = hwGrooveMount_HeadThickness + 2,d = 11, $fn = gcFacetMedium);

					cylinder(h = hwGrooveMount_HeadThickness + 3,d = 9, $fn = gcFacetMedium);

				}

				// bolt slot edges
				hull() {
					rotate([0,0,i * 120 - 72])
					translate([0, rpEffectorBase_BoltOffset + 3,0])
					cylinder(h = hwGrooveMount_HeadThickness, d = 2, $fn = gcFacetSmall);

					rotate([0,0,i * 120 - 75])
					translate([0, rpEffectorBase_BoltOffset - 3,0])
					cylinder(h = hwGrooveMount_HeadThickness, d = 2, $fn = gcFacetSmall);

					rotate([0,0,i * 120 - 72])
					translate([0, rpEffectorBase_BoltOffset - 4,0])
					cylinder(h = hwGrooveMount_HeadThickness, d = 2, $fn = gcFacetSmall);

					rotate([0,0,i * 120 - 60])
					translate([0, rpEffectorBase_BoltOffset,0])
					cylinder(h = hwGrooveMount_HeadThickness, d1 = 12, d2 = 10, $fn = gcFacetMedium);
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

			// grip details

			for (i = [ 0 : 1 : 11]) {
				hull() {
				rotate([0,0,i * 30])
					translate([0, 6.5,13])
					sphere(h = 1, $fn = gcFacetSmall);

				rotate([0,0,i * 30])
					translate([0, 6.5,7])
					sphere(h = 1, $fn = gcFacetSmall);
				}
			}

		}

		// carve out

		// filament path
		cylinder(h = 20, d = HW_Hole(4), $fn = gcFacetSmall);

		for (i = [0 : 1 : 2]) {

			for (j = [0 : 1 : 15]) {
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
		translate([0,0,0])
			cylinder(h = 20, d = 10, $fn = gcFacetMedium);

		translate([0,0,-0.1])
		cylinder(h = hwGrooveMount_HeadThickness + 1, d = hwGrooveMount_HeadDiameter + 1, $fn = gcFacetLarge);

		// carve off bottom
		translate([-50,-50,-100])
		cube([100, 100, 100]);

		// carve off top
		*translate([-50,-50,13])
		cube([100, 100, 100]);

	}

	*for (i = [0 : 1 : 2]) {
		rotate([0,0,i * 120 - 60])
			translate([0, rpEffectorBase_BoltOffset,hwGrooveMount_HeadThickness])
		rotate_extrude(angle = 180, convexity = 2, $fn = gcFacetLarge)
							translate([thumbScrewClearance /2 - 6, 0, 0])
							circle(d = 2);
		}

	rotate_extrude(convexity = 2, $fn = gcFacetLarge)
			rotate([0,0,90])
				LockRing_Profile();
}

// ---------------------------------------------------------------------------------------------------------------------

module LockRing_Profile() {
	difference() {
		union() {
		// top rounded shape
			hull() {
			translate([14, 5.5, 0])
				circle(d = 2, $fn = gcFacetSmall);
			translate([14, 6, 0])
				circle(d = 2, $fn = gcFacetSmall);

			translate([6.5,4.5,0])
			square([3,2.5]);
		}

		// taper bit at bottom of pushfit connector holder
		translate([6.5,6.5,0])
		square([2,2]);

		// bottom of pushfit connector
			hull() {
				translate([6.3, 2.6, 0])
				circle(d = 1, $fn = gcFacetSmall);

				translate([6.3, 7.5, 0])
				circle(d = 1, $fn = gcFacetSmall);

				translate([5.4, 2.6, 0])
				circle(d = 1, $fn = gcFacetSmall);

				translate([5.4, 7.5, 0])
				circle(d = 1, $fn = gcFacetSmall);
			}

			hull() {
				translate([4.5, 9.5, 0])
					circle(d = 4, $fn = gcFacetSmall);

				translate([6.3, 7.5, 0])
					circle(d = 1, $fn = gcFacetSmall);

				translate([3,8.5,0])
				square([2,2]);

				translate([0,8.5,0])
				square([2,2.8]);
			}
		}

		// carve out taper at the bottom of the pushfit connector
		hull() {
			translate([7.7,8.25,0])
			circle(d = 2.5, $fn = gcFacetSmall);

			translate([7,12.25,0])
			circle(d = 2.5, $fn = gcFacetSmall);

			translate([9.75,8.25,0])
			circle(d = 2.5, $fn = gcFacetSmall);
		}

		// carve out hole for groovemount hotend
		translate([0, 0, 0])
		square([4.9,8.2]);
	}
}
