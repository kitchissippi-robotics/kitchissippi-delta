// Kitchessippi 03.02 Prototype
// Created by Brian Cantin 2014

// Set this to true if using Metric hardware instead of SAE 
// NOTE - this functionality is incomplete, SAE is design default

HARDWARE_METRIC = false;

// Nuts and Bolts - Adjustable for SAE (default) or Metric
// TODO: Add dimensions for metric

hwNutRadius = HARDWARE_METRIC ? 0 : 4.8;
hwWasherRadius = HARDWARE_METRIC ? 0 : 6;
hwBoltRadius = HARDWARE_METRIC ? 2.3 : 2.4;


// 608zz Bearing Dimensions

hw608InnerRingRadius = 6;
hw608BoreRadius = 4.1;

RENDER_RESOLUTION = 50;