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
// Pin_Swivel_Arm.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;

	Part_Pin_Swivel_Arm();
	Hardware_Pin_Swivel_Arm();
} else {
	EnableSupport = false;
}

module Part_Pin_Swivel_Arm() {
	difference() {
		union() {
			// Right Side Pin Holder
			hull() {
				// Right base for the vertical pins
				translate([-rpArm_Spacing /2, 0, 0])
					cylinder(h = rpSwivelArmHeight, d = hwPin_Diameter + 3, $fn = gcFacetMedium);

				// Right base for the horizontal pins
				translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
				rotate([0,90,0])
					cylinder(h = rpArm_PinDepth, d = hwPin_Diameter +3, $fn = gcFacetMedium);

				// Right base for the horizontal pins
				*translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
				rotate([0,90,0])
					cylinder(h = rpArm_PinDepth - 2, d = rpSwivelArmHeight, $fn = gcFacetMedium);

				// Right base for the vertical pins
				translate([-rpArm_Spacing /2 + 5, - 5, 0])
					cylinder(h = rpSwivelArmHeight, d = 6, $fn = gcFacetSmall);
			}

			// Joining Arm
			difference() {
				offset = 10;
				diameter = 14;

				hull() {
					// Left base for the vertical pins
					translate([-rpArm_Spacing /2 + 5, - 5, 0])
						cylinder(h = rpSwivelArmHeight, d = 6, $fn = gcFacetSmall);

					// Right base for the vertical pins
					translate([rpArm_Spacing /2 - 5, - 5, 0])
						cylinder(h = rpSwivelArmHeight, d = 6, $fn = gcFacetSmall);

					translate([-rpArm_Spacing /2 + offset /2 + 1, -4, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
					rotate([0,90,0])
						cylinder(h = rpArm_Spacing - offset - 2, d = rpSwivelArmHeight, $fn = gcFacetMedium);
				}

				// carve out access space
				translate([-rpArm_Spacing /2 + offset /2, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
				rotate([0,90,0])
				cylinder(h = rpArm_Spacing - offset, d = diameter, $fn = gcFacetMedium);

				// carve out access space
				*translate([-rpArm_Spacing /2 + offset /2, 1, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
				rotate([0,90,0])
				cylinder(h = rpArm_Spacing - offset, d = diameter + 2, $fn = gcFacetMedium);
			}

			// Left Side Pin Holder
			hull() {
				// Left base for the vertical pins
				translate([rpArm_Spacing /2, 0, 0])
					cylinder(h = rpSwivelArmHeight, d = hwPin_Diameter + 3, $fn = gcFacetMedium);

				// Left base for the horizontal pins
				translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
					rotate([0,-90,0])
						cylinder(h = rpArm_PinDepth, d = hwPin_Diameter +3, $fn = gcFacetMedium);

				// Left base for the horizontal pins
					*translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
					rotate([0,-90,0])
						cylinder(h = rpArm_PinDepth - 2, d = rpSwivelArmHeight, $fn = gcFacetMedium);

				// Left base for the vertical pins
				translate([rpArm_Spacing /2 - 5, - 5, 0])
					cylinder(h = rpSwivelArmHeight, d = 6, $fn = gcFacetSmall);
			}
		}

		// carve out pins

		// Left vertical pins
		translate([-rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth)])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		translate([-rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + rpArm_PinSeparation])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Right vertical pins
		translate([rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth)])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		translate([rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + rpArm_PinSeparation])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Left horizontal pin
		translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
		rotate([0,90,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);

		// Right horizontal pin
		translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
		rotate([0,-90,0])
			cylinder(h = hwPin_Length, d = HW_Hole(hwPin_Diameter), $fn=gcFacetSmall);


	}
}

// *********************************************************************************************************************
// Draw Hardware (for reference)
// ---------------------------------------------------------------------------------------------------------------------

module Hardware_Pin_Swivel_Arm() {
// Left vertical pins
translate([-rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth)])
	Draw_Pin();

translate([-rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + rpArm_PinSeparation])
	Draw_Pin();

// Right vertical pins
translate([rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth)])
	Draw_Pin();

translate([rpArm_Spacing /2, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + rpArm_PinSeparation])
	Draw_Pin();

// Left horizontal pin
translate([-rpArm_Spacing /2 + hwPin_Diameter /2 + rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
rotate([0,90,0])
	Draw_Pin();

// Right horizontal pin
translate([rpArm_Spacing /2 - hwPin_Diameter /2 - rpArm_PinSeparation, 0, -(hwPin_Length - rpArm_PinDepth) + hwPin_Length + (rpArm_PinSeparation /2)])
rotate([0,-90,0])
	Draw_Pin();
}

// *********************************************************************************************************************
// Hardware Reference (TODO: Migrate to a global include file for use in other parts)
// ---------------------------------------------------------------------------------------------------------------------

module Draw_Pin() {
	%cylinder(h = hwPin_Length, d = hwPin_Diameter, $fn=gcFacetSmall);
}


