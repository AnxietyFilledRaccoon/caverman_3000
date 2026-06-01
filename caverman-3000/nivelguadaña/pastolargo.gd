extends Area2D

class_name pasto 
var cut := false


func _input_event(viewport, event, shape_idx):

	if cut:
		return

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			cut = true

			queue_free()
