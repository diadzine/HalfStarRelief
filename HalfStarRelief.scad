/*
	name: 		HalfStarRelief.scad
	author:		Aymeric B.
	date:		21.05.2014
*/


/****** PARAMETERS ****/
star_branches = 5;
star_outer_radius = 50;
star_inner_radius = 25;
star_elevation = 12;
base_height = 10;


/****** MODULES ****/
module BranchBase() {
	star_angle = 360/star_branches;
	x = star_inner_radius * cos(star_angle/2);
	y = star_inner_radius * sin(star_angle/2);
	polygon([[0, 0], [x, y], [star_outer_radius, 0], [x, -y]]);
}

module Base() {
	star_angle = 360/star_branches;
	linear_extrude(height=base_height) {
		for (s = [1:star_branches]) {
			rotate([0, 0, s*star_angle]) BranchBase();
		}
	}
}

module HalfBranch() {
	star_angle = 360 / star_branches;
	x = star_inner_radius * cos(star_angle/2);
	y = star_inner_radius * sin(star_angle/2);
	polyhedron(
		points = [[0, 0, 0], 
					[star_outer_radius, 0, 0], 
					[x, y, 0], 
					[0, 0, star_elevation]], 
		triangles = [[0, 1, 2], 
					[1, 3, 2], 
					[2, 3, 0], 
					[0, 3, 1]]);
}

module FullBranch() {
	union() {
		color("green") {
			HalfBranch();
		}
		color("red") {
			mirror([0, 1, 0]) HalfBranch();
		}
	}
}

module Relief() {
	star_angle = 360/star_branches;
	union() {
		for (s = [1:star_branches]) {
			rotate([0, 0, s*star_angle]) translate([0.001, 0, 0]) FullBranch();
		}
	}
}

module HalfStarRelief() {
	Base();
	translate([0, 0, base_height-0.001]) Relief();
}


/****** RENDERS ****/
HalfStarRelief();