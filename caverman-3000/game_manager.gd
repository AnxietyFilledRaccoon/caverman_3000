extends Node

@export var total_vidas: int = 3
var platita_total: int = 0
# Señal para avisar a la interfaz que las vidas cambiaron
signal vidas_actualizadas(vidas: int)
# Señalcita para avisar a la interfaz sobre que la platita cambio
signal platita_actualizada(platita: int)

func perder_vida():
	total_vidas -= 1
	emit_signal("vidas_actualizadas", total_vidas)
	get_tree().paused = true
	if total_vidas <= 0:
		game_over()
	else:
		siguiente_minijuego()

func ganar_nivel(tiempo_restante: float):
	var monto_base: int = 100
	var bonus_velocidad: int = int(tiempo_restante) * 20
	platita_total += monto_base + bonus_velocidad
	emit_signal("platita_actualizada", platita_total)
	print("Platita ganada: $%d | Total: $%d" % [monto_base + bonus_velocidad, platita_total])

func game_over():
	print("¡Has perdido todas tus vidas!")
	# Aquí puedes reiniciar el marcador de vidas a 3 y cargar la pantalla de Game Over
	total_vidas = 3 
	platita_total = 0
	get_tree().change_scene_to_file("res://game_over.tscn")
	get_tree().paused = false

func siguiente_minijuego():
	# Código para cargar el siguiente minijuego de la lista
	pass
