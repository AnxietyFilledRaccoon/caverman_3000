extends Node2D
#editor de nodos
@onready var player7 = $Playerlvl7
@onready var productos = $Productos
@onready var camion = $Camion
@onready var timer_juego = $TimerJuego
@onready var label_tiempo = $Ui/Control/LabelTiempo
@onready var label_p_restantes = $Ui/Control/LabelPRestantes
@onready var label_resultados = $Ui/Control/LabelResultado

#productos
@onready var total_productos = 5
@onready var productos_restantes = 5
#jugabilidad
var tiene_producto = false
var juego_activo = true
var en_movimiento = false
var tiempo_total = 6

func _ready():

	player7.position.x = productos.position.x

	timer_juego.wait_time = tiempo_total
	timer_juego.start()

	label_resultados.visible = false

	if !timer_juego.timeout.is_connected(_tiempo_agotado):
		timer_juego.timeout.connect(_tiempo_agotado)
	
	_actualizar_ui()


func _process(_delta: float) -> void:
	if !juego_activo:
		return
		
	var tiempo_restante = int (timer_juego.time_left) + 1
	label_tiempo.text = "Tiempo: %02d" % tiempo_restante
	

func _input(event: InputEvent) -> void:
	#Movimvento del jugador con las flechitas, solo si el juego esta activo y el jugador no esta en movimiento
	if !juego_activo:
		return
	if en_movimiento:
		return
	
	if event.is_action_pressed("move_left"):

		if !tiene_producto:
			_mover_player(productos.position.x, _al_llegar_productos)
	
	if event.is_action_pressed("move_right"):
		if tiene_producto:
			_mover_player(camion.position.x, _al_llegar_camion)

func _mover_player(destino_x, callback):

	en_movimiento = true

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(player7, "position:x", destino_x, 0.3)
	tween.tween_callback(func():
		en_movimiento = false
		callback.call()
	)

func _al_llegar_productos() -> void:
	if productos_restantes > 0:
		tiene_producto = true
		_actualizar_ui()

func _al_llegar_camion() -> void:
	tiene_producto = false
	productos_restantes -= 1
	_actualizar_ui()
	
	if productos_restantes <= 0:
		_fin_juego(true)

#ui
func _actualizar_ui() -> void:
	label_p_restantes.text = "Productos restantes: %d" % productos_restantes

func _tiempo_agotado() -> void:
	_fin_juego(false)

func _fin_juego(gano: bool) -> void:
	juego_activo = false
	timer_juego.stop()
	label_resultados.visible = true
	if gano:
		await get_tree().create_timer(2.0).timeout
		label_resultados.text = "¡Entregaste todos los productos!"
		get_tree().change_scene_to_file("res://nivel8/nivel8.tscn")
	else:
		await get_tree().create_timer(1.0).timeout
		label_resultados.text = "¡Perdiste!" + "\n" + "se termino el tiempo"
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://game_over.tscn")
	#await get_tree().create_timer(2.0).timeout
	#get_tree().change_scene_to_file("res://nivel8/nivel8.tscn")
