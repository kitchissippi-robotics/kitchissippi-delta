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

include <OpenSCAD-Hardware/HardwareLib.scad>
include <Configuration.scad>

// ---------------------------------------------------------------------------------------------------------------------
// Enable multipart mode
// .....................................................................................................................
// This disables built in support material and automatic rendering of the parts

MultiPartMode = true;

// Set the rendering colour design

colourPrimary = "Black";
colourSecondary = "Lime";

// Inner Carriage

include <LinearCarriage_Inner.scad>

//color(colourPrimary)
translate([0,0,15])
mirror([0,0,1])
Part_LC_Inner();

// Outer Carriage

include <LinearCarriage_Outer.scad>

//color(colourSecondary)
translate([0,0,-15])
Part_LC_Outer();

// Carriage Adapter

include <CarriageAdapter.scad>

//color(colourSecondary)
translate([0,0,15])
Part_CarriageAdapter();
