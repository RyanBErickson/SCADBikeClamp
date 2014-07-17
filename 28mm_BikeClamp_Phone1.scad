quality = 20; // 200 for final export...

c_post_size = 29;          			// Size of Bike post to fit (mine is 28mmx29mm)
c_gap = c_post_size / 2;

c_height = 30;							// How tall to make clamp side
c_thickness = 5;						// How thick (around post)
c_edge = 1.5;								// Bevel edge size

c_tab_mult = c_thickness * 2.8;		// Width of side tabs (relative)
c_hole_radius = 1.5;					// Radius of screw holes

c_phone_height = 10;					// Height of phone above post

c_phone_width = 74;					// Width between side clamps
c_phone_clamp_length = 100;		// Length of clamp arm
c_phone_thickness = 14;				// Thickness 


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

		// 'left' tab
		translate([c_gap, - (c_thickness + 1), 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);

		// 'right' tab
		translate([-(c_gap + c_tab_mult), - (c_thickness + 1), 0])
			cube([c_tab_mult, c_thickness, c_height], center=false);

		// Phone height block
		translate([-(c_post_size * 1.5/4), -(c_phone_height + c_gap), 0])
			cube([c_post_size * 3/4, c_phone_height, c_height], center=false);

		linear_extrude(height = c_phone_height, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) 
		{
			// TODO: Fix this polygon to be oriented the right way, and to
			// build the right profile for the phone params:
			// (c_phone_width, c_phone_thickness)

			translate([0, -40, 0])
				polygon( points=[[0,0],
					[c_thickness - c_edge, 0],
					[c_thickness, c_edge],
					[c_thickness, c_height-c_edge],
					[c_thickness - c_edge, c_height],
					[0, c_height]] );

		}

	}

	// Subtractive 'difference' items below...

	// Screw holes
	translate([c_gap + (c_tab_mult * .66), c_thickness + 1, (c_height / 4)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);

	translate([-(c_gap + (c_tab_mult * .66)), c_thickness + 1, (c_height / 4)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);


	translate([c_gap + (c_tab_mult * .66), c_thickness + 1, (c_height - c_height / 4)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);

	translate([-(c_gap + (c_tab_mult * .66)), c_thickness + 1, (c_height - c_height / 4)])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3);

	// Remove unused half clamp
	translate([-(c_gap+c_thickness), -1, 0])
		cube([(c_gap + c_thickness) * 2, (c_gap + c_thickness + 1) * 2, c_height], center=false);


}