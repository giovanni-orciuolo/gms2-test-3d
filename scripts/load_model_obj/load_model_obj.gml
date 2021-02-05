/// Loads an OBJ file into Game Maker. Pass undefined to mtl_filename if you don't want to provide a material for the model
/// @param obj_filename
/// @param mtl_filename
/// @param color
/// @param alpha
/// @param swap
function load_model_obj(obj_filename, mtl_filename, color, alpha, swap) {
	var obj_file = file_text_open_read(working_directory + obj_filename);
	if (obj_file == -1) {
		show_message("Model load failed because no OBJ file was found: '" + obj_filename + "'.");
		return undefined;
	}
	
	var mtl_file = -1;
	if (mtl_filename != undefined) {
		mtl_file = file_text_open_read(working_directory + mtl_filename);
		if (mtl_file == -1) {
			show_message("Model load failed because no MTL file was found: '" + mtl_filename + "'.");
			return undefined;
		}
	}
	
	var model = vertex_create_buffer();
	
	// OBJ property lists
	var vertex_x = ds_list_create(), vertex_y = ds_list_create(), vertex_z = ds_list_create();
	var vertex_nx = ds_list_create(), vertex_ny = ds_list_create(), vertex_nz = ds_list_create();
	var vertex_xtex = ds_list_create(), vertex_ytex = ds_list_create();
	
	// MTL property maps
	var mtl_alpha = ds_map_create();
	var mtl_color = ds_map_create();
	var mtl_name = "None", active_mtl_name = "None";
	
	// Parse MTL file if present
	if (mtl_file != -1) {
		while (!file_text_eof(mtl_file)) {
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			
			var terms = string_split(line, " ");
			switch (terms[0]) {
				case "newmtl": // Material name
					mtl_name = terms[1];
				break;
				case "Kd": // Color
					var r = real(terms[1]) * 255,
						g = real(terms[2]) * 255,
						b = real(terms[3]) * 255;
					mtl_color[? mtl_name] = make_color_rgb(r, g, b);
				break;
				case "d": // Alpha ("dissolved")
					mtl_alpha[? mtl_name] = real(terms[1]);
				break;
			}
		}
	}
	
	// Parse OBJ file
	vertex_begin(model, obj_world.vertex_format);
	
	while (!file_text_eof(obj_file)) {
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		
		// Split string by token " ", place tokens into terms
		var terms = string_split(line, " ");
		
		// Add elements to the lists based on the first term
		switch (terms[0]) {
			case "v":
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
			break;
			case "vt":
				ds_list_add(vertex_xtex, real(terms[1]));
				ds_list_add(vertex_ytex, real(terms[2]));
			break;
			case "vn":
				ds_list_add(vertex_nx, real(terms[1]));
				ds_list_add(vertex_ny, real(terms[2]));
				ds_list_add(vertex_nz, real(terms[3]));
			break;
			case "f": // This is a descriptor
				for (var i = 1; i <= 3; i++) {
					var indexes = string_split(terms[i], "/");
					
					// Based on the parsed indexes, find data in the associated lists
					// The OBJ format starts counting at 1, so we need to subtract 1 here
					var xx = ds_list_find_value(vertex_x, real(indexes[0]) - 1),
						yy = ds_list_find_value(vertex_y, real(indexes[0]) - 1),
						zz = ds_list_find_value(vertex_z, real(indexes[0]) - 1);
					var xtex = ds_list_find_value(vertex_xtex, real(indexes[1]) - 1),
						ytex = ds_list_find_value(vertex_ytex, real(indexes[1]) - 1);
					var nx = ds_list_find_value(vertex_nx, real(indexes[2]) - 1),
						ny = ds_list_find_value(vertex_ny, real(indexes[2]) - 1),
						nz = ds_list_find_value(vertex_nz, real(indexes[2]) - 1);
						
					if (ds_map_exists(mtl_color, active_mtl_name)) {
						// Override color/alpha configs
						color = mtl_color[? active_mtl_name];
						alpha = mtl_alpha[? active_mtl_name];
					}
					
					// Optional: swap the y and z positions (useful if you used the default Blender export settings)
					if (swap) {
						var t = yy;
						yy = zz;
						zz = t;
					}
						
					// Setup position 3D, normal and texcoord
					// This is where the model is actually built
					vertex_position_3d(model, xx, yy, zz);
					vertex_normal(model, nx, ny, nz);
					vertex_texcoord(model, xtex, ytex);
					vertex_color(model, color, alpha);
				}
			break;
			case "usemtl":
				active_mtl_name = terms[1];
			break;
		}
	}
	
	// The entire file has been parsed
	// End the model setup and destroy all the temporary lists
	
	vertex_end(model);
	
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);
	
	ds_map_destroy(mtl_alpha);
	ds_map_destroy(mtl_color);
	
	file_text_close(obj_file);
	if (mtl_file != -1) { file_text_close(mtl_file); }
	
	return model;
}