extends Node2D
var bicho_aplastado := 0
var bicho_total := 7
var bicho = preload("res://nivelelbicho/bicho.tscn")
@onready var contador_label = $CanvasLayer/contador

func _ready():
	randomize()

	for i in range(bicho_total):
		var nuevo_bicho = bicho.instantiate()

		nuevo_bicho.position = Vector2(
			randi_range(100, 700),
			randi_range(100, 500)
		)

		add_child(nuevo_bicho)

	actualizar_contador()


func actualizar_contador():
	contador_label.text =str(bicho_aplastado) +"/"+ str(bicho_total)

func sumar_bicho():
	bicho_aplastado += 1
	
	$CanvasLayer/contador.text =str(bicho_aplastado) +"/7"
	if bicho_aplastado >= bicho_total:
			get_tree().change_scene_to_file("res://nivelcarton/juegocarton.tscn")
	print("aplastado:",bicho_aplastado)
	actualizar_contador() 
	if bicho_aplastado >= bicho_total:
		finalizar()

func finalizar():
	print("Nivel completado")

func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()
