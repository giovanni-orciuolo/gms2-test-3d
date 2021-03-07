view_enabled = true;
view_set_visible(0, true);

camera = camera_create();

projection_matrix = matrix_build_projection_perspective_fov(
	// FOV
	45,
	// Aspect Ratio (4:3, 16:9, etc...)
	view_get_wport(0) / view_get_hport(0),
	// Clipping planes (anything farther than zfar won't be drawn)
	1, 32000
);
camera_set_proj_mat(camera, projection_matrix);
camera_set_update_script(camera, camera_update);
view_set_camera(0, camera);

yaw = 0;
yaw_step = 2.5;
yaw_goal = 0;
z = 32;
distance = 300;