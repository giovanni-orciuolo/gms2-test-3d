if (!window_has_focus()) {
	return;
}

if (keyboard_check(vk_up)) {
	distance += 10;
}
if (keyboard_check(vk_down)) {
	distance -= 10;
}
if (keyboard_check_pressed(vk_right) && yaw == yaw_goal) {
	yaw_goal -= 45;
}
if (keyboard_check_pressed(vk_left) && yaw == yaw_goal) {
	yaw_goal += 45;
}

if (keyboard_check(vk_tab)) {
	obj_world.ship.xrot += 10;
}

distance = clamp(distance, 0, 300);

if (yaw < yaw_goal) {
	yaw += yaw_step;
}
if (yaw > yaw_goal) {
	yaw -= yaw_step;
}

// Normalize yaw
if (yaw > 360) {
	yaw = 0;
}
if (yaw_goal > 360) {
	yaw_goal = 0;
}


if (keyboard_check(vk_escape)) {
	game_end();
}