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
// dimensions.scad
// *********************************************************************************************************************

include <Configuration.scad>

// Nuts and Bolts - Adjustable for SAE (default) or Metric
// TODO: Add dimensions for metric

hwNutRadius = HARDWARE_METRIC ? 0 : 4.8;
hwWasherRadius = HARDWARE_METRIC ? 0 : 6;
hwBoltRadius = HARDWARE_METRIC ? 2.3 : 2.4;

// 608zz Bearing Dimensions

hw608InnerRingRadius = 6;
hw608BoreRadius = 4.1;

// Carriage Settings

rpLC_Carriage_HorizontalPostSpacing = 45;	// 45 from SketchUp Design
rpLC_Carriage_VerticalPostSpacing = 30;		// 29 from SketchUp Design

// ---------------------------------------------------------------------------------------------------------------------
// Pin - Bicycle chain pins extracted from chain for 5~6-speed cassette
// .....................................................................................................................

// Edit these if your pins are a different size

hwPin_Diameter = 3.6;	// bicycle chain pin diameter (in mm)
hwPin_Length = 7.8;	// bicycle chain pin length (in mm)



rpArm_Spacing = 50;		// space between the rods on the same plane (in mm)
rpArm_PinSeparation = 1;	// space between the two vertical pins (in mm)
rpArm_PinDepth	= 5.2;		// how far the stationary pins should be embedded (in mm)

rpSwivelArmHeight = rpArm_PinDepth * 2 + rpArm_PinSeparation;
