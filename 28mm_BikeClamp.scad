quality = 20; // 200 for final export...

c_post_size = 29;          			// Size of Bike post to fit (mine is 28mmx29mm)
c_gap = c_post_size / 2;

c_height = 10;							// How tall to make clamp side
c_thickness = 5;						// How thick (around post)
c_edge = 1.5;								// Bevel edge size

c_tab_mult = c_thickness * 2.8;		// Width of side tabs (relative)
c_hole_radius = 1.5;					// Radius of screw holes


difference()
{
	// Additive items within union...
	union()
	{

		// Main circle
		rotate_extrude($fn=quality)
			translate([c_gap, 0, 0])
				polygon( points=[[0,0],
					[c_thickness - c_edge, 0],
					[c_thickness, c_edge],
					[c_thickness, c_height-c_edge],
					[c_thickness - c_edge, c_height],
					[0, c_height]] );

		// 'left' tabs
		translate([c_gap, 1, 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);
		translate([c_gap, - (c_thickness + 1), 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);

		// 'right' tabs
		translate([-(c_gap + c_tab_mult), 1, 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);
		translate([-(c_gap + c_tab_mult), - (c_thickness + 1), 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);

	}

	// Subtractive 'difference' items below...

	// Split into two parts
	translate([-(c_thickness + c_gap), -1, 0])
		cube([(c_gap + c_thickness) * 2, 2, c_height], center=false);

	// Screw holes
	translate([c_gap + (c_tab_mult * .66), c_thickness + 1, (c_height / 2)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);
	translate([-(c_gap + (c_tab_mult * .66)), c_thickness + 1, (c_height / 2)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);

}
