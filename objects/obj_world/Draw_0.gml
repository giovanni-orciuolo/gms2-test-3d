shader_set(shd_light);

shader_set_uniform_f(shader_get_uniform(shd_light, "lightDirection"), -1, 1, -1);
shader_set_uniform_f(shader_get_uniform(shd_light, "lightColor"), 1, 0.5, 0.5, 1);
shader_set_uniform_f(shader_get_uniform(shd_light, "lightAmbientColor"), 0.25, 0.25, 0.25, 1);

draw_floor(floor_vbuf, spr_grass);

with (obj_model) {
	event_perform(ev_draw, 0);
}
with (obj_billboard) {
	event_perform(ev_draw, 0);
}

shader_reset();