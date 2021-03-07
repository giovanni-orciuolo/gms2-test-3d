/// CALL THIS IN DRAW EVENT
/// @param vbuffer
/// @param sprite
function draw_floor(vbuffer, sprite) {
	vertex_submit(vbuffer, pr_trianglelist, sprite_get_texture(sprite, 0));
}