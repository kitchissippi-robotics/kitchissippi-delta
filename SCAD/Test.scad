// Temporary test file to test some maths
RENDER_LEVEL = 3;
NOZZLE_SIZE = 0.5;
include <OpenSCAD-Hardware/HW_Bolts.scad>

//include <OpenSCAD-Hardware/FFM_Functions.scad>

difference() {
	hull() {
		translate([15,0,0])
			cylinder(h = 5, d = 4, $fn=gcFacetSmall);

		translate([10,5,0])
			cylinder(h = 6, d = 6, $fn=gcFacetSmall);

		translate([-10,5,0])
			cylinder(h = 5, d = 4, $fn=gcFacetSmall);

		translate([-10,-5,0])
			cylinder(h = 5, d = 4, $fn=gcFacetSmall);

		translate([-20,0,0])
			cylinder(h = 5, d = 4, $fn=gcFacetSmall);

		translate([10,-5,0])
			cylinder(h = 5, d = 6, $fn=gcFacetSmall);
	}

	nozzleSize = 0.5;

	compensateOne = (nozzleSize * 0.75) *2;
	compensateTwo = (nozzleSize * 0.75) *2;

	translate([-10,0,-0.1])
		cylinder(h = 6, d = 4, $fn=gcFacetSmall);

	translate([5,0,0])
		Carve_hwBolt(hwM4_Bolt_AllenHead, 15);

	translate([5,0,0])
		Draw_hwBolt(hwM4_Bolt_AllenHead, 15);

	translate([-2.5,0,0])
		Carve_hwBolt(hwNo8_Bolt_PanHead, 15);

	translate([-2.5,0,0])
		Draw_hwBolt(hwNo8_Bolt_PanHead, 15);

	// pin hole test
	translate([10,5,1])
		cylinder(h = 5.2, d = HW_Hole(3.6), $fn=gcFacetSmall);

	translate([10,-5,1])
		cylinder(h = 5.2, d = HW_Hole(3.6), $fn=gcFacetSmall);

	translate([-22,0,-0.1])
		cylinder(h = 5.2, d = 2, $fn=gcFacetSmall);
}
