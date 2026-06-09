extends Area2D
func _input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			get_parent().recolectar_caja()

			queue_free()
