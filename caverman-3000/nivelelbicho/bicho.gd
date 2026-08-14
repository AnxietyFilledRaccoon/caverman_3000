extends Area2D
var velocidad = 150
var direccion = Vector2.ZERO
var muerto = false
func _ready():

	direccion = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	elegir_objetivo()




func _process(delta):
	if muerto:
		return

	global_position = global_position.move_toward(
		objetivo,
		velocidad * delta
	)

	if global_position.distance_to(objetivo) < 10:
		elegir_objetivo()

var objetivo := Vector2.ZERO

func elegir_objetivo():

	var margen := 32

	objetivo = Vector2(
		randf_range(margen, 1152 - margen),
		randf_range(margen, 648 - margen)
	)

func morir():
	if muerto:
		return

	muerto = true

	# Cambiar al sprite de bicho muerto
	$Sprite2D.texture = preload("res://nivelelbicho/bichomuerto.png")

	# Desactivar la colisión para que no pueda aplastarse otra vez
	$CollisionShape2D.disabled = true

	get_parent().sumar_bicho()

	# Esperar un segundo antes de eliminarlo
	await get_tree().create_timer(1.0).timeout
	queue_free()
