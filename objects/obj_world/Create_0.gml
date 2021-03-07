gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
// gpu_set_fog(true, c_red, 100, 1000);

// Begin creation of vertex format
vertex_format_begin();

// Accept XYZ positional data in the vertex format
vertex_format_add_position_3d();

// Optional parameters
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();

// Save the newly created vertex format in a variable
vertex_format = vertex_format_end();

ship = instance_create_depth(500, 0, depth, obj_model);
ship.model = load_model_obj("merry.obj", "merry.mtl", c_aqua, 1, false);
ship.z = -100;

floor_vbuf = init_floor();
