/// CALL IN CREATE EVENT
function init_floor() {
	vbuffer = vertex_create_buffer();
	vertex_begin(vbuffer, vertex_format);

	var s = 128;
	for (var i = 0; i < room_width; i += s) {
	    for (var j = 0; j < room_height; j += s) {
	        vertex_add_point(vbuffer, i, j, 0,                  0, 0, 1,        0, 0,       c_white, 1);
	        vertex_add_point(vbuffer, i + s, j, 0,              0, 0, 1,        1, 0,       c_white, 1);
	        vertex_add_point(vbuffer, i + s, j + s, 0,          0, 0, 1,        1, 1,       c_white, 1);

	        vertex_add_point(vbuffer, i + s, j + s, 0,          0, 0, 1,        1, 1,       c_white, 1);
	        vertex_add_point(vbuffer, i, j + s, 0,              0, 0, 1,        0, 1,       c_white, 1);
	        vertex_add_point(vbuffer, i, j, 0,                  0, 0, 1,        0, 0,       c_white, 1);
	    }
	}

	vertex_end(vbuffer);
	return vbuffer;
}