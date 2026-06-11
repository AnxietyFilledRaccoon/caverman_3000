extends Node

var escena_transicion = preload("res://transicion_nivel.tscn")

func cambiar_nivel(nombre_nivel:String,
	controles:String,
	ruta_escena:String):

	var transicion = escena_transicion.instantiate()

	get_tree().root.add_child(transicion)

	transicion.iniciar(nombre_nivel, controles, ruta_escena)
