function camera_update() {
	var cam = obj_camera;
	var cam_dir = cam.direction, cam_pitch = cam.pitch
	
	var matrix = matrix_build_lookat(
		cam.x, cam.y, cam.z,
		cam.x + dcos(cam_dir), cam.y - dsin(cam_dir), cam.z - dsin(cam_pitch),
		0, 0, -1
	);

	camera_set_view_mat(view_camera[0], matrix);
}