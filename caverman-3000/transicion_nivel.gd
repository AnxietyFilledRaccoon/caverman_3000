extends CanvasLayer

#@onready var texto = $ColorRect/Label

var siguiente_escena = ""
@onready var mecanica_actual = $TextureRect/VBoxContainer/Labelmecanica
@onready var label_nivel = $TextureRect/VBoxContainer/Labelmecanica2


	

func iniciar(nombre_nivel:String, controles:String, ruta_escena:String):

	label_nivel.text = nombre_nivel
	mecanica_actual.text = controles
	siguiente_escena = ruta_escena

	mostrar_transicion()


	mostrar_transicion()


func mostrar_transicion() -> void:

	visible = true

	await get_tree().create_timer(2.0).timeout
	
	visible = false
	get_tree().change_scene_to_file(siguiente_escena)
