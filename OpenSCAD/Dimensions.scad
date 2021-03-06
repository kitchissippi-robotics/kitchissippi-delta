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

hw608Thickness = 7;
hw608OutsideDiameter = 21.8;
hw608InsideDiameter = 8;
hw608HubDiameter = 12;

hwSpacerCompressionFactor = 0.2;

// Carriage Settings

rpLC_Carriage_HorizontalPostSpacing = 45;	// 45 from SketchUp Design
rpLC_Carriage_VerticalPostSpacing = 30;		// 29 from SketchUp Design

// ---------------------------------------------------------------------------------------------------------------------
// Pin - Bicycle chain pins extracted from chain for 5~6-speed cassette
// .....................................................................................................................

// Edit these if your pins are a different size

hwPin_Diameter = 3.6;	// bicycle chain pin diameter (in mm)
hwPin_Length = 7.8;	// bicycle chain pin length (in mm)

// ---------------------------------------------------------------------------------------------------------------------
// Arm Rod - 1/4" aluminum rod
// .....................................................................................................................

hwArmRod_Diameter = 6.35;	// 1/4" to mm = 6.35 (rod has been sanded and filed, this may need to be adjusted
hwArmRod_Length = 300;		// rods are cut and filed down to 300mm in length

// ---------------------------------------------------------------------------------------------------------------------
// Arm Pin Dimensions
// .....................................................................................................................

rpArm_Spacing = 50;			// 	51; space between the rods on the same plane (in mm)
rpArm_PinSeparation = 1;	// space between the two vertical pins (in mm)
rpArm_PinDepth	= 5.2;		// how far the stationary pins should be embedded (in mm)

rpSwivelArmHeight = rpArm_PinDepth * 2 + rpArm_PinSeparation;

// ---------------------------------------------------------------------------------------------------------------------
// Arm_CarriageAdapter Dimensions
// .....................................................................................................................

rpCarriageAdapter_MountSpacing = 39;	// 39;	spacing between bolts to mount to the linear carriage
rpCarriageAdapter_AdjustmentNutOffset = 15;	// 15.1; vertical offset from center line for the adjustment nut
rpCarriageAdapter_AdjustmentBoltOffset = 2.5;	// 2.5; vertical offset of the adjustment bolt
rpCarriageAdapter_SwivelOffset = 19; 	// 19; Offset of swivel from the base
rpCarriageAdapter_BaseBoltThickness = 5;
rpCarriageAdapter_BaseThickness = 2;
rpCarriageAdapter_BaseLength = 36;
rpCarriageAdapter_BaseWidth = 31;
rpCarriageAdapter_AdjustmentWasherOffset = 22.5;

rpCarriageAdapter_BeltPathWidth = 8.9;
rpCarriageAdapter_BeltPathOffset = 8.9;

rpCarriageAdapter_HosePostDiameter = 8;

rpBearing_DefaultSpacing = 23 * 2;	// baseline horizontal spacing of the bearing clusters if they were touching
rpBearing_UpperOffset = 15;
rpBearing_LowerOffset = 20;

rpLC_CarriageThickness = 18;	// distance between the center line of the mechanism and the outside edge where the adapter mounts to
rpLC_OuterCarriageThickness = 17;	// distance between the center line of the mechanism and the outside edge where the adapter mounts to


hwUpperBearingSpacerWidth = 4.0;
hwLowerBearingSpacerWidth = 7.0;

// ---------------------------------------------------------------------------------------------------------------------
// Arm_RodEnd Dimensions
// .....................................................................................................................

rpArmRod_InsertDepth = 20;		// 15.5;	depth the arm rod is inserted into the rod end
rpArmRod_HolderThickness = 2;	// how thick the rod holder should be around the rod

rpRodEnd_SwivelClearance = 16;

// ---------------------------------------------------------------------------------------------------------------------
// Effector_Base Dimensions
// .....................................................................................................................

rpEffectorBase_SwivelOffset = 35;	// distance from center that the pin swivels will sit at
rpEffectorBase_SwivelZOffset = 10;
rpEffectorBase_BoltOffset = 24.25;		// distance from center that the bolt mounts will sit at
rpEffectorBase_HotendOpening = 12.2;	// size of the central openning for the hotend
rpEffectorBase_Thickness = 6;

rpEffectorBase_FanOffset = 15;
rpEffectorBase_FanAngle = -22;

hwGrooveMount_HeadThickness = 4.8;
hwGrooveMount_HeadDiameter = 16.2;



