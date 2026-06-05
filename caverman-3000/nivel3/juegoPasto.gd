extends Node2D
var pasto_total := 6
var pasto_cortado := 0
@onready var contador_label = $CanvasLayer/contador
# Called when the node enters the scene tree for the first time.



func _ready():
	pasto_total = get_tree().get_nodes_in_group("pasto").size()
	actualizar_contador()
func sumar_corte():
	pasto_cortado += 1
	
	$CanvasLayer/contador.text =str(pasto_cortado) +"/6"
	if pasto_cortado ==6:
		get_tree().change_scene_to_file("res://nivel1/juego1.tscn")
	print("cortados:", pasto_cortado)
	actualizar_contador() 
	if pasto_cortado >= pasto_total:
		finalizar()
		
		
func finalizar():
	print("Nivel completado")



func actualizar_contador():
	contador_label.text =str(pasto_cortado) +"/"+ str(pasto_total)


func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()
