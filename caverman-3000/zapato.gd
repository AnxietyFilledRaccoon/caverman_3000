extends Area2D

func _process(_delta):
	global_position = get_global_mouse_position()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		for area in get_overlapping_areas():
			if area.has_method("morir"):
				area.morir()
