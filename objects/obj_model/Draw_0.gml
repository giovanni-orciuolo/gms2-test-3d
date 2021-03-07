if (model != undefined) {
	var pos_matrix = matrix_build(x, y, z, 0, 0, 0, 1, 1, 1);
	var rot_matrix = matrix_build(0, 0, 0, xrot, yrot, zrot, 1, 1, 1);
	
	var final_matrix = matrix_multiply(pos_matrix, rot_matrix);
	matrix_set(matrix_world, final_matrix);
	vertex_submit(model, pr_trianglelist, -1);
	matrix_set(matrix_world, matrix_build_identity());
}