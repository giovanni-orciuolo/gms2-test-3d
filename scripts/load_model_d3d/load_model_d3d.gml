/// @param filename
function load_model_d3d(filename) {

	var file = file_text_open_read(filename);
	if (file == -1) {
		show_message("Model load failed because no D3D file was found: '" + filename + "'.");
		return undefined;
	}
	
	var version = file_text_read_real(file);
	if (version != 100) {
		show_message("Model load failed because D3D version is " + version + ". Only version 100 is supported.");
		file_text_close(file);
		return undefined;
	}

	var n = file_text_read_real(file);
	file_text_readln(file);

	var line; line[10] = 0;
	
	var model = vertex_create_buffer();
	vertex_begin(model, obj_world.vertex_format);

	for (var i = 0; i < n; i++) {
		for (var j = 0; j < 11; j++) {
			line[j] = file_text_read_real(file);
		}
		
		var type = line[0];
		switch (type) {
			case 0:
				// Primitive start
			break;
			case 1:
				// Primitive end
			break;
			case 2:	// Vertex position
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				vertex_add_point(model, xx, yy, -zz, 0, 0, 0, 0, 0, c_white, 1);
			break;
			case 3:	// Vertex position and color
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var color = line[4],
					alpha = line[5];
				vertex_add_point(model, xx, yy, -zz, 0, 0, 0, 0, 0, color, alpha);
			break;
			case 4:	// Vertex position, texture
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var xtex = line[4],
					ytex = line[5];
				vertex_add_point(model, xx, yy, -zz, 0, 0, 0, xtex, ytex, c_white, 1);
			break;
			case 5:	// Vertex position, texture, color
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var xtex = line[4],
					ytex = line[5];
				var color = line[4],
					alpha = line[5];
				vertex_add_point(model, xx, yy, -zz, 0, 0, 0, color, alpha, xtex, ytex);
			break;
			case 6:	// Vertex position, normal
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var nx = line[4],
					ny = line[5],
					nz = line[6];
				vertex_add_point(model, xx, yy, -zz, nx, ny, -nz, c_white, 1, 0, 0);
			break;
			case 7:	// Vertex position, normal, color
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var nx = line[4],
					ny = line[5],
					nz = line[6];
				var color = line[7],
					alpha = line[8];
				vertex_add_point(model, xx, yy, -zz, nx, ny, -nz, color, alpha, 0, 0);
			break;
			case 8:	// Vertex position, normal, texture
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var nx = line[4],
					ny = line[5],
					nz = line[6];
				var xtex = line[7],
					ytex = line[8];
				vertex_add_point(model, xx, yy, -zz, nx, ny, -nz, xtex, ytex, c_white, 1);
			break;
			case 9:	// Vertex position, normal, texture, color
				var xx = line[1],
					yy = line[2],
					zz = line[3];
				var nx = line[4],
					ny = line[5],
					nz = line[6];
				var xtex = line[7],
					ytex = line[8];
				var color = line[9],
					alpha = line[10];
				vertex_add_point(model, xx, yy, -zz, nx, ny, -nz, xtex, ytex, color, alpha);
			break;
			case 10: // Block
			break;
			case 11: // Cylinder
			break;
			case 12: // Cone
			break;
			case 13: // Ellipsoid
			break;
			case 14: // Wall
			break;
			case 15: // Floor
			break;
		}
	}

	file_text_close(file);
	vertex_end(model);

	return model;
}