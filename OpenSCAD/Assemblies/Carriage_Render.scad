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
// LinearCarriage_Render.scad
// Does not generate any parts, used for OpenSCAD visual rendering of assembly
// *********************************************************************************************************************

// ---------------------------------------------------------------------------------------------------------------------
// Include and Configure the Hardware Library
// .....................................................................................................................

include <../Configuration.scad>
include <../Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

// ---------------------------------------------------------------------------------------------------------------------
// Enable multipart mode
// .....................................................................................................................
// This disables built in support material and automatic rendering of the parts

MultiPartMode = true;

// Set the rendering colour design

colourPrimary = "Black";
colourSecondary = "Yellow";
colourTertiary = "Gray";

// Inner Carriage

include <../Carriage_Inner.scad>

color(colourPrimary)
translate([0,0,rpLC_CarriageThickness])
mirror([0,0,1])
Part_LC_Inner();

// Outer Carriage

include <../Carriage_Outer.scad>

color(colourSecondary)
translate([0,0,-rpLC_OuterCarriageThickness])
Part_LC_Outer();

// Carriage Adapter

include <../Arm_CarriageAdapter.scad>

color(colourTertiary)
translate([0,0,rpLC_CarriageThickness])
Part_CarriageAdapter();

rotate([90,0,0])
translate([0,0,-50])
rotate([0,0,45])
hw_SteelTube();

rotate([90,90,0])
translate([0,0,rpBearing_UpperOffset])
Draw_BearingCluster(4.4);

rotate([90,90,0])
translate([0,0,-rpBearing_LowerOffset])
Draw_BearingCluster(7.6);
