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
// Configuration.scad
// Does not generate any parts, used for project global configuration
// *********************************************************************************************************************

// Set this to true if using Metric hardware instead of SAE
// NOTE - this functionality is incomplete, SAE is design default
// Ultimated the Kitchissippi-Delta is a mix of hardware types

HARDWARE_METRIC = false;

//

NOZZLE_SIZE = 0.5;
RENDER_LEVEL = 4;	// use 1 for screen quality, 4 for print quality
SLICER_COMPENSATION = 0.0;
