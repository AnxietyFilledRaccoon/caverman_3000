extends Area2D



func ready():
	pass
	
func _process(delta) -> void:
	$Amano.global_position = get_global_mouse_position()
	$CollisionShape2D.global_position = get_global_mouse_position()

	
