extends Node2D
var cajas_recolectadas = 0
var cajas_totales = 4

func _ready():
	$CanvasLayer/contador.text = "0/4"

func recolectar_caja():

	cajas_recolectadas += 1

	$CanvasLayer/contador.text = str(cajas_recolectadas) + "/" + str(cajas_totales)

	if cajas_recolectadas >= cajas_totales:
		get_tree().change_scene_to_file("res://nivelguadaña/juego_pasto.tscn")

func _on_reiniciar_pressed() -> void:
		# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()
