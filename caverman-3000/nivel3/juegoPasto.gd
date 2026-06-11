extends Node2D
var pasto_total := 6
var pasto_cortado := 0
@onready var contador_label = $CanvasLayer/contador
# Called when the node enters the scene tree for the first time.



func _ready():
	$CanvasLayer/contador.text = "0/4"
	#pasto_total = get_tree().get_nodes_in_group("pasto").size()
	actualizar_contador()
	
func sumar_corte():
	pasto_cortado += 1
	
	$CanvasLayer/contador.text =str(pasto_cortado) + "/" + str(pasto_total)
	if pasto_cortado >= pasto_total:
		$eventos.nivel_ganado()
		TransicionManager.cambiar_nivel(
		"Prepara",
		"Usa Espacio","")# puedo agregar en el espacio libre la siguiente pantalla
		#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://nivelketchup/escena_ketchup.tscn")
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
