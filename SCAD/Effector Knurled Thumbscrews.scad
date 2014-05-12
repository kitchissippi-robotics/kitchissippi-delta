

use <knurledFinishLib_v2.scad>

difference() {
	knurl(k_cyl_hg	= 15,	k_cyl_od	= 15);
	translate([0,0,6])
		cylinder(h = 10, r1 = 4, r2=5, $fn=6);
	cylinder(h = 10, r = 2);
};


