extends Node2D
#puse onreadys, para que sea facil modificar y testear
@onready var timer_semaforo = $timersemaforo
@onready var timer_juego = $timerjuego
@onready var auto1 = $auto1
@onready var auto2 = $auto2
@onready var semaforo_luz = $semaforo
@onready var player1 = $player8
@onready var label_resultado = $UI/VBoxContainer/LabelResultado

var semaforo_verde: bool = false
var paso: float = 40.0
var meta_x: float = 520.0
var velocidad_auto1: float = 200.0
var velocidad_auto2: float = -180.0
var juego_activo: bool = true


func _ready() -> void:
	_actualizar_color_semaforo()
	
	timer_semaforo.wait_time = randf_range(1.5, 3.0)
	timer_semaforo.start()
	
	timer_juego.wait_time = 8.0
	timer_juego.start()
	
	label_resultado.visible = false
	
	if not timer_semaforo.timeout.is_connected(_cambiar_semaforo):
		timer_semaforo.timeout.connect(_cambiar_semaforo)
	if not timer_juego.timeout.is_connected(_tiempo_agotado):
		timer_juego.timeout.connect(_tiempo_agotado)
	
func _cambiar_semaforo():
	semaforo_verde = !semaforo_verde
	_actualizar_color_semaforo()
	
	timer_semaforo.wait_time = randf_range(1.5, 3.0)
	timer_semaforo.start()
	

func _process(delta: float) -> void:
	if !juego_activo:
		return
	auto1.position.x += velocidad_auto1 * delta
	auto2.position.x += velocidad_auto2 * delta
	
	if auto1.position.x > 640:
		auto1.position.x = -80
	if auto2.position.x < -80:
		auto2.position.x = 640
	
func _actualizar_color_semaforo():
	if semaforo_verde:
		semaforo_luz.modulate = Color(0,1,0)
	else:
		semaforo_luz.modulate = Color(1,0,0)

func _input(event: InputEvent) -> void:
	if !juego_activo:
		return
	if event.is_action_pressed("ui_up"):
		if !semaforo_verde:
			_fin_juego(false) 
		else:
			player1.position.x += paso
			if player1.position.x >= meta_x:
				_fin_juego(true)
func _tiempo_agotado():
	_fin_juego(false)

func _fin_juego(gano: bool):
	juego_activo = false
	timer_semaforo.stop()
	timer_juego.stop()
	
	label_resultado.visible = true
	
	if gano:
		label_resultado.text = "¡Llegaste por suerte!"
	else:
		label_resultado.text = "¡Te atropellaron, no se logró!"
