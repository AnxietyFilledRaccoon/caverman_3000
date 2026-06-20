extends Node2D
var cajas_recolectadas = 0
var cajas_totales = 4


func _ready():
	var spawns = [
		$"spawn 1",
		$"spawn 2",
		$"spawn 3",
		$"spawn 4"
	]
	spawns.shuffle()
	#$caja.position = spawns[0].position
	#$caja2.position =spawns[1].position
	#$caja3.position =spawns[2].position
	#$caja4.position =spawns[3].position
	$CanvasLayer/contador.text = "0/4"
	

func recolectar_caja():

	cajas_recolectadas += 1

	$CanvasLayer/contador.text = str(cajas_recolectadas) + "/" + str(cajas_totales)

	if cajas_recolectadas >= cajas_totales:
		$eventos.nivel_ganado()
		TransicionManager.cambiar_nivel("Cortar",
	preload("res://asets/Fondos y otras escenas/Botones/Mouse2.png"),
	"")# puedo agregar en el espacio libre la siguiente pantalla
		#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://nivelguadaña/juego_pasto.tscn")
		

func _on_reiniciar_pressed() -> void:
		# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()
