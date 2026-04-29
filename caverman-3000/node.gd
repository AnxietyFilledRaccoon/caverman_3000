extends Node

@onready var timer_node = $Timer
@onready var label_node = $CanvasLayer/Label
	
	
	
func _process(_delta):
	# Muestra el tiempo restante redondeado
	label_node.text = "Tiempo: " + str(round(timer_node.time_left))
	await get_tree().create_timer(1.0).timeout


func _on_timer_timeout() -> void:
	label_node.text = "¡Tiempo agotado!"
	# se puede agregar logica (ej. reiniciar escena)
	print("El tiempo ha terminado")
	
	

	
