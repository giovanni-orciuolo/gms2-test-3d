/// @description Movement

view_angle = obj_camera.yaw;

var vertical = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var horizontal = keyboard_check(ord("D")) - keyboard_check(ord("A"));
 
var move_direction = point_direction(0, 0, horizontal, vertical);
var move_distance = point_distance(0, 0, horizontal, vertical);

x += dcos(move_direction + view_angle + 90) * move_distance * spd;
y -= dsin(move_direction + view_angle + 90) * move_distance * spd;