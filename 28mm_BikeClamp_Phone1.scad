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

		// Phone height block
		translate([-(c_post_size * 1.5/4), -(c_phone_height + c_gap), 0])
			cube([c_post_size * 3/4, c_phone_height, c_height], center=false);


		// Hull from point-to-point for smoothed corners...
		hull()
{
		translate([(-c_phone_width / 2)-(c_bracket_thickness / 2) + c_bracket_tab - c_bracket_thickness, c_start_bracket_y - c_phone_thickness- c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(-c_phone_width / 2)-c_bracket_thickness / 2, c_start_bracket_y - c_phone_thickness- c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}
		hull()
{
		translate([(-c_phone_width / 2)-c_bracket_thickness / 2, c_start_bracket_y - c_phone_thickness- c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(-c_phone_width / 2)-c_bracket_thickness / 2, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}


		hull()
{
		translate([(-c_phone_width / 2)-c_bracket_thickness / 2, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);

		translate([(c_phone_width / 2)+c_bracket_thickness / 2, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}


		hull()
{
		translate([(c_phone_width / 2)+c_bracket_thickness / 2, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(c_phone_width / 2)+c_bracket_thickness / 2, c_start_bracket_y - c_phone_thickness - c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}

		hull()
{
		translate([(c_phone_width / 2)+c_bracket_thickness / 2, c_start_bracket_y - c_phone_thickness - c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(c_phone_width / 2)+c_bracket_thickness / 2 - (c_bracket_tab - c_bracket_thickness), c_start_bracket_y - c_phone_thickness - c_bracket_thickness, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}

// Add reinforcing braces on side legs...
		hull()
{
		translate([15, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);

		translate([5, c_start_bracket_y+7.5, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([-5, c_start_bracket_y+7.5, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);

		translate([-15, c_start_bracket_y, z_offset]) cylinder(c_height / 2, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}


	}

	// Subtractive 'difference' items below...
		linear_extrude(height = c_height, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) 
		{
			// build the right profile for the phone params:
			// (c_phone_width, c_phone_thickness)

			translate([-(c_post_size*1/4), -(c_gap+c_phone_height), 0])
				polygon( points=[[0,0],
					[0,c_bracket_thickness], 
					[(c_post_size*1/2)+.5,c_bracket_thickness], 
					[(c_post_size*1/2)+.5, 0]
				]);

		}

	translate([0, 0, c_height/2])
		rotate([90, 0, 0])
			cylinder(c_post_size+c_phone_height+10, c_hole_radius, c_hole_radius, $fn=quality / 3, center=true);

	translate([0, 0, c_height/2])
		rotate([90, 0, 0])
			cylinder(c_post_size+4, 4, 4, $fn=6, center=true);
/*
	translate([0, 0, 0])
		rotate([90, 0, 0])
			cylinder(c_thickness * 2 + 2, c_hole_radius, c_hole_radius, $fn=quality / 3, center=true);
*/

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
