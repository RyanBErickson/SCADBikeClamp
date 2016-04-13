quality = 200; // 200 for final export...

c_post_size = 29;          			// Size of Bike post to fit (mine is 28mmx29mm)
c_gap = c_post_size / 2;

c_height = 30;							// How tall to make clamp side
c_thickness = 5;						// How thick (around post)
c_edge = 1.5;								// Bevel edge size

c_tab_mult = c_thickness * 2.8;		// Width of side tabs (relative)
c_hole_radius = 1.5;					// Radius of screw holes

c_phone_height = 11;

// MODIFY THESE FOR YOUR PHONE...
c_phone_width = 80.5;		// Width between side clamps (orig 74, new phone 80.5)
c_phone_thickness = 16;		// Thickness of phone (front-back) (orig 14, new 16)
// ---- end Phone-specific...

c_phone_clamp_length = 120;		// Length of clamp arm (orig 100, new 120)

c_bracket_thickness = c_thickness * .66;
c_bracket_tab = c_tab_mult * .66;

c_start_bracket_y = -(c_phone_height + c_gap - c_bracket_thickness / 2);
z_offset = 0;

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
	}

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
