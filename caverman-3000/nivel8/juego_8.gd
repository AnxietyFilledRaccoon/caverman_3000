extends Node2D
#puse onreadys, para que sea facil modificar y testear
@onready var timer_semaforo = $timersemaforo
@onready var timer_juego = $timerjuego
@onready var auto1 = $auto1
@onready var auto2 = $auto2
@onready var semaforo_luz = $semaforo
@onready var player1 = $player8
@onready var label_resultado = $UI/LabelResultado

var semaforo_verde: bool = false
var paso: float = 40.0
var meta_x: float = 520.0
var velocidad_auto1: float = 200.0
var velocidad_auto2: float = -180.0
var juego_activo: bool = true


func _ready() -> void:
	timer_semaforo.wait_time = randf_range(1.5, 3.0)
	timer_semaforo.start()
	pass
	
func _cambiar_semaforo():
	semaforo_verde = !semaforo_verde
	_actualizar_color_semaforo()
	
	timer_semaforo.wait_time = randf_range(1.5, 3.0)
	timer_semaforo.start()
func _actualizar_color_semaforo():
	if semaforo_verde:
		semaforo_luz.modulate = Color(0,1,0)
	else:
		semaforo_luz.modulate = Color(1,0,0)

func _tiempo_agotado():
	_fin_juego(false)

func _fin_juego(gano: bool):
	juego_activo = false
	timer_semaforo.stop()
	timer_juego.stop()
	
	label_resultado.visible = true
	
	if gano:
		label_resultado.text = "¡Llegaste!"
	else:
		label_resultado.text = "¡Te atropellaron!"
