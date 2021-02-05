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

draw_set_lighting(true);
draw_light_define_point(1, 0, 0, 0, room_width, c_white);
draw_light_enable(1, true);
draw_light_define_point(2, 600, 600, 200, room_width, c_white);
draw_light_enable(2, true);

var ship = instance_create_depth(500, 0, depth, obj_model);
ship.model = load_model_obj("merry.obj", "merry.mtl", c_white, 1, true);
ship.z = 0;