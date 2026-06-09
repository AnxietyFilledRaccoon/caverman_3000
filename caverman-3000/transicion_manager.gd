extends Node

var escena_transicion = preload("res://transicion_nivel.tscn")

func cambiar_nivel(nombre_nivel, mecanica, ruta_escena):

	var transicion = escena_transicion.instantiate()

	get_tree().root.add_child(transicion)

	transicion.iniciar(nombre_nivel, mecanica, ruta_escena)
