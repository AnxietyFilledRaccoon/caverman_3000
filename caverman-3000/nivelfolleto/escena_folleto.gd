extends Node2D

# Variables base
var personaje
var etiqueta_puntaje
var pantalla_victoria
var puntaje = 0
var puntaje_objetivo = 25

# Rango del PJ
var posicion_izquierda = Vector2(200, 300)
var posicion_derecha = Vector2(600, 300)

# Variable para posicionamiento y control de si se está moviendo
var esta_a_la_derecha = false
var moviendose = false

func _ready():
	personaje = $Player
	etiqueta_puntaje = $ScoreLabel
	pantalla_victoria = $CanvasLayer/VictoryScreen

	personaje.position = posicion_izquierda
	pantalla_victoria.visible = false

	actualizar_puntaje()

func _input(event):
	if event.is_action_pressed("hit") and !moviendose and puntaje < puntaje_objetivo:
		puntaje += 1
		actualizar_puntaje()

		moviendose = true

		var destino

		if esta_a_la_derecha:
			destino = posicion_izquierda
		else:
			destino = posicion_derecha

		esta_a_la_derecha = !esta_a_la_derecha

		var animacion = create_tween()
		animacion.tween_property(personaje, "position", destino, 0.3)

		await animacion.finished
		moviendose = false

		if puntaje >= puntaje_objetivo:
			mostrar_victoria()


func actualizar_puntaje():
	etiqueta_puntaje.text = "Folletos repartidos: " + str(puntaje) + "/" + str(puntaje_objetivo)


func mostrar_victoria():
	pantalla_victoria.visible = true
