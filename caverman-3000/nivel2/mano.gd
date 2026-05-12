extends Area2D

@export var tamaño = 0.5


func _ready():
	scale = Vector2(tamaño, tamaño)
	
func _process(delta) -> void:
	$Amano.global_position = get_global_mouse_position()
	$CollisionShape2D.global_position = get_global_mouse_position()

	
