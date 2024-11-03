include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/transforms.scad>

// Minimum angle
$fa = 0.1;
// Minimum size
$fs = 0.1;

width = 88;
base_height = 60;
arm_height = 30;
base_width = 20;
mount_hole_offset = 10.85; // plus radius
mount_hole_radius = 2.07;
arm_length = 25;
arm_thickness = 5;
mount_arm = 100;
frame_screw_r = 3;
frame_screw_offset = 5 + frame_screw_r;

module frame_screw_hole(z_offset) {
    back(arm_thickness / 2)
        up(z_offset)
        right((base_width / sqrt(2) / 2))
        rotate([90, 0, 0]) #cylinder(h = arm_thickness, r = frame_screw_r, center=true);
}

module mount_screw_hole(x_offset, y_offset, z_offset) {
    back(arm_thickness)
        up(z_offset)
	right(x_offset)
	back(y_offset)
	rotate([90, 0, 90])
        #cylinder(h = arm_thickness, r = mount_hole_radius);
}

difference() {
    union() {
	rotate([0, 0, 45]) cube([arm_thickness, arm_length, base_height]);
	cube([base_width / sqrt(2), arm_thickness, base_height]);
	back(arm_length / sqrt(2)) left(arm_length / sqrt(2)) cube([arm_thickness, mount_arm, base_height]);
    }
    frame_screw_hole(frame_screw_offset);
    frame_screw_hole(base_height - frame_screw_offset);
    off = mount_hole_offset + mount_hole_radius;
    z_offset = base_height/2 - off/2;
    x_offset = - (arm_length / sqrt(2));
    y_offset = arm_length / sqrt(2) + mount_arm - off * 2;
    mount_screw_hole(x_offset, y_offset, z_offset);
    mount_screw_hole(x_offset, y_offset, z_offset + off);
    mount_screw_hole(x_offset, y_offset + off, z_offset + off);
    mount_screw_hole(x_offset, y_offset + off, z_offset);
}