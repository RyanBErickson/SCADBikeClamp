quality = 60; // 200 for final export...

difference()
{
   // Build main structure
	translate([0, 0, 0]) {
		cube([100, 20, 10], center=true);
		rotate_extrude(convexity = 10)
		{
			translate([30, 0, 0])
				circle(r=6, $fn=quality);
		}
	}

   // Remove main cylinder from toroid
	translate([0, 0, -10])
		cylinder(20, 28, 28, $fn=quality);

   // Flatten top and bottom of toroid
	translate([0, 0, -6])
		cube([100, 100, 2], center=true);
	translate([0, 0, 6])
		cube([100, 100, 2], center=true);

   // Split into two even pieces
	translate([0, 0, 0])
		cube([100, 2, 20], center=true);

	// Remove for hex nut
	//translate([42, -8, 0])
		//rotate([90, 0, 0])
			//cylinder(4, 5, 5, $fn=6);

	// Remove for hex bolt heads
	translate([42, -7, 0])
		rotate([90, 0, 0])
			cylinder(4, 4, 4, $fn=40);
	translate([42, 11, 0])
		rotate([90, 0, 0])
			cylinder(4, 4, 4, $fn=40);
	translate([-42, -7, 0])
		rotate([90, 0, 0])
			cylinder(4, 4, 4, $fn=40);
	translate([-42, 11, 0])
		rotate([90, 0, 0])
			cylinder(4, 4, 4, $fn=40);


	// Drill holes
	translate([42, 15, 0])
		rotate([90, 0, 0])
			cylinder(30, 2, 2, $fn=20);

	translate([-42, 15, 0])
		rotate([90, 0, 0])
			cylinder(30, 2, 2, $fn=20);
}

