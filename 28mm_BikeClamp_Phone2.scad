quality = 200; // 200 for final export...

c_post_size = 29;          			// Size of Bike post to fit (mine is 28mmx29mm)
c_gap = c_post_size / 2;

c_height = c_post_size / 2;				// How tall to make clamp side
c_thickness = 5;						// How thick (around post)
c_edge = 1.5;								// Bevel edge size

c_tab_mult = c_thickness * 2.8;		// Width of side tabs (relative)
c_hole_radius = 1.5;					// Radius of screw holes

c_phone_height = 10;					// Height of phone above post

c_phone_width = 80.5;		          // Width between side clamps (orig 74, new phone 80.5)
c_phone_clamp_length = 90;	 		// Length of clamp arm
c_phone_thickness = 16;		      // Thickness of phone (front-back) (orig 14, new 16)

c_bracket_thickness = c_thickness * .66;
c_bracket_tab = c_tab_mult * .66;

z_offset = 0;

difference()
{
	// Additive items within union...
	union()
	{

		// Hull from point-to-point for smoothed corners...
		hull()
{
		translate([c_bracket_thickness / 2, c_bracket_thickness / 2, z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(c_bracket_thickness / 2) + c_phone_clamp_length, c_bracket_thickness / 2, z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}
hull()
{
		translate([(c_bracket_thickness / 2) + c_phone_clamp_length, c_bracket_thickness / 2, z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(c_bracket_thickness / 2) + c_phone_clamp_length, (c_bracket_thickness / 2)-(c_phone_thickness + c_bracket_thickness), z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}
hull()
{
		translate([(c_bracket_thickness / 2) + c_phone_clamp_length, (c_bracket_thickness / 2)-(c_phone_thickness + c_bracket_thickness), z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
		translate([(c_bracket_thickness / 2) + c_phone_clamp_length - c_bracket_tab + c_bracket_thickness, (c_bracket_thickness / 2)-(c_phone_thickness + c_bracket_thickness), z_offset]) cylinder(c_height, c_bracket_thickness / 2, c_bracket_thickness / 2, $fn=quality);
}


	}
}
