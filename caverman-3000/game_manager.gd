extends Node

@export var total_vidas: int = 3

# Señal para avisar a la interfaz que las vidas cambiaron
signal vidas_actualizadas(vidas: int)

func perder_vida():
	total_vidas -= 1
	emit_signal("vidas_actualizadas", total_vidas)
	get_tree().paused = true
	if total_vidas <= 0:
		game_over()
	else:
		await (get_tree().create_timer(0.5).timeout)
		get_tree().paused = true
		siguiente_minijuego()

func game_over():
	print("¡Has perdido todas tus vidas!")
	# Aquí puedes reiniciar el marcador de vidas a 3 y cargar la pantalla de Game Over
	total_vidas = 3 
	get_tree().change_scene_to_file("res://game_over.tscn")
	get_tree().paused = false

func siguiente_minijuego():
	# Código para cargar el siguiente minijuego de la lista
	pass
