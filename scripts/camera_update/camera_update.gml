function camera_update() {
	var player = obj_player, camera = obj_camera;
	var camera_distance = camera.distance;
	
	var xto = player.x, yto = player.y, zto = player.z;
	var xfrom = xto + camera_distance * dcos(obj_camera.yaw),
		yfrom = yto - camera_distance * dsin(obj_camera.yaw),
		zfrom = zto - camera_distance;
	
	var matrix = matrix_build_lookat(
		xfrom, yfrom, zfrom,
		xto, yto, zto,
		0, 0, 1
	);

	camera_set_view_mat(view_camera[0], matrix);
}