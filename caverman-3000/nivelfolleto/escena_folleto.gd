extends Node2D

# Variables base
var personaje
var pantalla_victoria
var puntaje = 0
var puntaje_objetivo = 30

# Rango del PJ
var posicion_izquierda = Vector2(550, 300)
var posicion_derecha = Vector2(650, 300)

# Variable para posicionamiento y control de si se está moviendo el cusifae este
var esta_a_la_derecha = false
var moviendose = false

func _ready():
	personaje = $personaje
	pantalla_victoria = $CanvasLayer/pantalla_victoria
	$transeunte.play("idle")

	personaje.position = posicion_izquierda
	pantalla_victoria.visible = false

func _input(event):
	if event.is_action_pressed("hit") and !moviendose and puntaje < puntaje_objetivo:
		puntaje += 1
		moviendose = true

		var destino

		if esta_a_la_derecha:
			destino = posicion_izquierda
		else:
			destino = posicion_derecha
		
		personaje.flip_h = !personaje.flip_h
		esta_a_la_derecha = !esta_a_la_derecha

		var animacion = create_tween()
		animacion.tween_property(personaje, "position", destino, 0.15)

		await animacion.finished
		moviendose = false

		if puntaje >= puntaje_objetivo:
			mostrar_victoria()

#func actualizar_puntaje():
#	etiqueta_puntaje.text = "Folletos repartidos: " + str(puntaje) + "/" + str(puntaje_objetivo)

func mostrar_victoria():
	pantalla_victoria.visible = true
	$eventos.nivel_ganado()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("")
