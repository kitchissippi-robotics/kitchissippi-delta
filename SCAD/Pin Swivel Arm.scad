// *****************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *****************************************************************************
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2015 Kitchissippi Robotics
// -----------------------------------------------------------------------------
// K03.11 - Pin Swivel Arm
// *****************************************************************************

include <OpenSCAD-Utilities/Hardware - Metric.scad>

// ### some dimensions

// Pin - Bicycle chain pins extracted from chain for 5~6-speed cassette

hw_Pin_Diameter = 3.6;	// bicycle chain pin diameter (in mm)
hw_Pin_Length = 7.8;	// bicycle chain pin length (in mm)

Rod_Spacing = 50;		// space between the rods on the same plane (in mm)
TiltPin_Spacing = 1;	// space between the two vertical pins (in mm)

// *****************************************************************************

Draw_Pin();

// *****************************************************************************


module Draw_Pin() {
	cylinder(h = hw_Pin_Length, d = hw_Pin_Diameter, $fn=24);
}


