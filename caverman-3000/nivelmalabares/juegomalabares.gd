extends Node2D
@onready var contador_label = $CanvasLayer/contador
var pantalla_final_scene = preload("res://plata_vida_total.tscn")
var pulsaciones := 0
var objetivo := 30
var nivel_terminado = false
@onready var personaje = $personaje


func _ready():
	actualizar_contador()

func _input(event):

	if nivel_terminado:
		return

	if event.is_action_pressed("ui_accept"):

		pulsaciones += 1

		personaje.hacer_malabar()

		actualizar_contador()

		if pulsaciones >= objetivo:
			finalizar()

func actualizar_contador():
	contador_label.text = str(pulsaciones) + "/" + str(objetivo)

func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()



func final_score():
	print("nivel completado")
	var eventos= get_node_or_null("eventos")
	if eventos:
		eventos.nivel_ganado
		
		#pantalla final
	var pantalla_final = pantalla_final_scene.instantiate()
	add_child(pantalla_final)
	pantalla_final.position = Vector2.ZERO
	pantalla_final.size = get_viewport().get_visible_rect().size
	
func finalizar():
	nivel_terminado = true
	print("Nivel completado")
	var eventos = get_node_or_null("eventos")
	if eventos:
		eventos.nivel_ganado()
		
	#Pantalla final con resultados de plata y vida restante
	var pantalla_final = pantalla_final_scene.instantiate()
	add_child(pantalla_final)
	pantalla_final.position = Vector2.ZERO
	pantalla_final.size = get_viewport().get_visible_rect().size
	personaje.terminar()
