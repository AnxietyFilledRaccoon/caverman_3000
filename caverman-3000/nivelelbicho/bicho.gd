extends Area2D
var velocidad = 150
var direccion = Vector2.ZERO

func _ready():

	direccion = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	elegir_objetivo()




func _process(delta):
	global_position = global_position.move_toward(
		objetivo,
		velocidad * delta
	)
	if global_position.distance_to(objetivo) < 10:
		elegir_objetivo()

	position += direccion * velocidad * delta

var objetivo := Vector2.ZERO
func elegir_objetivo():

	objetivo = Vector2(
		randf_range(100, 1100),
		randf_range(150, 600)
	)

func morir():
	get_parent().sumar_bicho()
	queue_free()
