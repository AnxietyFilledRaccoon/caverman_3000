extends Control



# Referencia al Label que muestra el tiempo
@onready var tiempo_label = $CanvasLayer/tiempo
@onready var game_timer = $tiempoJuego
@export var tiempo_personalizar = 0
@onready var restart_menu = null

func _ready():
	restart_menu = get_node_or_null("../botonreinicio")
	$tiempoJuego.wait_time = tiempo_personalizar #me permite modificar timer por inspector para distintas escenas
	# Iniciar el timer al comenzar
	await get_tree().create_timer(1.0).timeout #desactivo el "AUTOSTART" en el inspector
											   #con este await le doy un tiempo de retraso al timer
	game_timer.start()#inicia el timer
	
func _process(_delta):
	# Actualizar el texto del label cada frame con el tiempo restante
	# ceil() redondea hacia arriba para mostrar el segundo actual correcto
	tiempo_label.text = str(ceil($tiempoJuego.time_left))
func nivel_ganado():
	var tiempo_restante = game_timer.time_left
	game_timer.stop()
	GameManager.ganar_nivel(tiempo_restante)


func _on_tiempo_juego_timeout() -> void:
	
	print("se acabo el tiempo")
# Esta función se ejecuta cuando el tiempo llega a cero
# aca puedo cambiar de escena o activar Game Over
	GameManager.perder_vida()
	if restart_menu:
		restart_menu.visible = true # aparece el boton cuando se pierde
	#get_tree().change_scene_to_file("res://game_over.tscn")
