extends Node

@onready var timer_node = $Timer
@onready var label_node = $CanvasLayer/Label
	
	
func _process(_delta):
	# Muestra el tiempo restante redondeado
	label_node.text = "Tiempo: " + str(round(timer_node.time_left))


func _on_timer_timeout() -> void:
	label_node.text = "¡Tiempo agotado!"
	# Aquí puedes agregar lógica adicional (ej. reiniciar escena) [8]
	print("El tiempo ha terminado")
	
	

	
