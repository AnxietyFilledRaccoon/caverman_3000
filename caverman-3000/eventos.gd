extends Control


	
# Referencia al Label que muestra el tiempo
@onready var tiempo_label = $CanvasLayer/tiempo
@onready var game_timer = $tiempoJuego

func _ready():
	# Iniciar el timer al comenzar
	await get_tree().create_timer(1.0).timeout #desactivo el "AUTOSTART" en el inspector
											   #con este await le doy un tiempo de retraso al timer
	game_timer.start()#inicia el timer

func _process(_delta):
	# Actualizar el texto del label cada frame con el tiempo restante
	# ceil() redondea hacia arriba para mostrar el segundo actual correcto
	tiempo_label.text = str(ceil($tiempoJuego.time_left))



func _on_tiempo_juego_timeout() -> void:
	print("se acabo el tiempo")
# Esta función se ejecuta cuando el tiempo llega a cero
# aca puedo cambiar de escena o activar Game Over
	get_tree().change_scene_to_file("res://game_over.tscn")
