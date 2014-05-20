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
module Base() {
	cylinder(r=star_outer_radius, h=base_height);
}

module HalfBranch() {
	polyhedron(points = [[0, 0, 0], [star_outer_radius, 0, 0], [star_inner_radius, 25, 0], [0, 0, star_elevation]], triangles = [[0, 1, 2], [1, 3, 2], [2, 3, 0], [0, 3, 1]]);
}

module FullBranch() {
	color("green") {
		HalfBranch();
	}
	color("red") {
		mirror([0, 1, 0]) HalfBranch();
	}
}

module Relief() {
	star_angle = 360/star_branches;
	for (s = [1:star_branches]) {
		rotate([0, 0, s*star_angle]) FullBranch();
	}
}

module HalfStarRelief() {
	Base();
	translate([0, 0, base_height]) Relief();
}

module hexagram(size, height) {
  boxWidth=size/1.75;
  for (v = [[0,1],[0,-1],[1,-1]]) {
    intersection() {
      rotate([0,0,60*v[0]]) cube([size, boxWidth, height], true);
      rotate([0,0,60*v[1]]) cube([size, boxWidth, height], true);
    }
  }
}

module complexObject() {

}


/****** RENDERS ****/
HalfStarRelief();
//complexObject();