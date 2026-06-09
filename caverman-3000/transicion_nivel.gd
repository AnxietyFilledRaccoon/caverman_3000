extends CanvasLayer

@onready var texto = $ColorRect/Label

var siguiente_escena = ""
var mecanica = ""
var nombre_nivel = ""

func iniciar(nombre, mecanica, escena):

	nombre_nivel = nombre
	mecanica = mecanica
	siguiente_escena = escena

	texto.text = nombre_nivel
	texto.text = mecanica

	mostrar_transicion()


func mostrar_transicion() -> void:

	visible = true

	await get_tree().create_timer(2.0).timeout
	
	visible = false
	get_tree().change_scene_to_file(siguiente_escena)
