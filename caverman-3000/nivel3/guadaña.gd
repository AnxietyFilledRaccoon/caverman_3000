extends Area2D

func _process(delta):

	global_position = get_global_mouse_position()


func _on_area_entered(area):

	if area.has_method("cut_grass"):
		area.cut_grass()
