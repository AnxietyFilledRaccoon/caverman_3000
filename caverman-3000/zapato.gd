extends Area2D
var activo = true
func _process(_delta):
	if !activo:
		return
	global_position = get_global_mouse_position()

func _input_event(viewport, event, shape_idx):
	if !activo:
		return
	if event is InputEventMouseButton:
		for area in get_overlapping_areas():
			if area.has_method("morir"):
				area.morir()
