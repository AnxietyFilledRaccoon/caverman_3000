extends Area2D

func _process(_delta):
	global_position = get_global_mouse_position()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		for area in get_overlapping_areas():
			if area.has_method("morir"):
				area.morir()
