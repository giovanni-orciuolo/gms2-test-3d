/// @param vbuffer
/// @param xx
/// @param yy
/// @param zz
/// @param nx
/// @param ny
/// @param nz
/// @param utex
/// @param vtex
/// @param color
/// @param alpha
function vertex_add_point(
	vbuffer,
	xx, yy, zz,  // Position in 3d space
	nx, ny, nz,  // Normal vector, useful for reflections
	utex, vtex,  // Texture coordinates (u/v or xtex/ytex)
	color, alpha // Color and alpha
) {
	vertex_position_3d(vbuffer, xx, yy, zz); // Position in 3d space
	vertex_normal(vbuffer, nx, ny, nz); // Useful to determine where light is reflected
	vertex_texcoord(vbuffer, utex, vtex); // Texture coordinates (u/v or xtex/ytex)
	vertex_color(vbuffer, color, alpha); // Color, obviously
}