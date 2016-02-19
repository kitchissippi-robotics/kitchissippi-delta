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

// Render Settings

RENDER_RESOLUTION = 50;

// Carriage Settings

rpLC_Carriage_HorizontalPostSpacing = 45;	// 45 from SketchUp Design
rpLC_Carriage_VerticalPostSpacing = 30;		// 29 from SketchUp Design
