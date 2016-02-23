// *********************************************************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *********************************************************************************************************************
// Kitchissippi Delta 3D Printer - Prototype
//
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2014-2016 Kitchissippi Robotics
// ---------------------------------------------------------------------------------------------------------------------
// LinearCarriage_Inner.scad
// *********************************************************************************************************************

include <Dimensions.scad>
include <Carriage_Common.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (MultiPartMode == undef) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_LC_Inner();
} else {
	EnableSupport = false;
}

// render setting

$fn = 20;

// *********************************************************************************************************************

module Part_LC_Inner() {

	difference() {
		union() {
			difference() {
				_LC_Inner_Base();

				translate([0, 0, 2])
				scale([0.90, 0.90, 1])
					_LC_Inner_Base();
			}

			// post bases
			translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
				LC_BearingPostBase();

			translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
				LC_BearingPostBase();

			translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
				LC_BearingPostBase();

			translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
				LC_BearingPostBase();

			// bearing surface
			translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 6])
				cylinder(d1 = 15, r = hw608BoreRadius, h = 1);

			translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 6])
				cylinder(d1 = 15, r = hw608BoreRadius, h = 1);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 6])
				cylinder(d1 = 15, r = hw608BoreRadius, h = 1);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 6])
				cylinder(d1 = 15, r = hw608BoreRadius, h = 1);

			// bearing holder
			translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 5.2])
				cylinder(r=hw608BoreRadius, h =7.2);

			translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 5.2])
				cylinder(r=hw608BoreRadius, h =7.2);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 5.2])
				cylinder(r=hw608BoreRadius, h =7.2);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 5.2])
				cylinder(r=hw608BoreRadius, h =7.2);

			// spacer holder
			translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2,12.2])
				cylinder(r=hw608BoreRadius - 0.5, h= 1.5);

			translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2,12.2])
				cylinder(r=hw608BoreRadius - 0.5, h= 1.5);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2,12.2])
				cylinder(r=hw608BoreRadius - 0.5, h= 1.5);

			translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2,12.2])
				cylinder(r=hw608BoreRadius - 0.5, h= 1.5);

	}



		// nut carveout
		translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius);

		translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius);

		translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius);

		translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(h = 4.3, r = hwWasherRadius);


		// bolt carveout
		translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(r=hwBoltRadius, h =20);

		translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(r=hwBoltRadius, h =20);

		translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(r=hwBoltRadius, h =20);

		translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, -0.1])
			cylinder(r=hwBoltRadius, h =20);
	}
}

// ---------------------------------------------------------------------------------------------------------------------

module _LC_Inner_Base() {
	hull() {
		translate([-rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([-rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([rpLC_Carriage_HorizontalPostSpacing /2, -rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();

		translate([rpLC_Carriage_HorizontalPostSpacing /2, rpLC_Carriage_VerticalPostSpacing /2, 0])
			LC_BearingPostBase();
	}
}
