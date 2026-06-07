extends Node2D
#editor de nodos
@onready var player7 = $Playerlvl7
@onready var productos = $Estanteria/Productos
@onready var camion = $Camion
@onready var timer_juego = $TimerJuego
@onready var label_tiempo = $Ui/Control/LabelTiempo
@onready var label_p_restantes = $Ui/Control/LabelPRestantes
@onready var label_resultados = $Ui/Control/LabelResultado

#productos
@onready var total_productos = 5
@onready var productos_restantes = 5
@onready var productos_nodos = $Estanteria/Productos.get_children()
@onready var productos_total = $Playerlvl7/Productos
@onready var productos_entregados_nodos = $Camion/ProductosEntregados.get_children()
#jugabilidad
var tiene_producto = false
var juego_activo = true
var en_movimiento = false
var tiempo_total = 7

func _ready():

	player7.position.x = (productos.position.x + camion.position.x) / 2.0

	timer_juego.wait_time = tiempo_total
	timer_juego.start()

	label_resultados.visible = false

	if !timer_juego.timeout.is_connected(_tiempo_agotado):
		timer_juego.timeout.connect(_tiempo_agotado)
	
	productos_total.visible = false

	_actualizar_ui()
	_actualizar_productos_visuales()




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
			_mover_player(productos.position.x, _al_llegar_productos, true)
	
	if event.is_action_pressed("move_right"):
		if tiene_producto:
			_mover_player(camion.position.x, _al_llegar_camion, false)

func _mover_player(destino_x, callback, mirar_izquierda) -> void:

	en_movimiento = true

	var sprites = player7.find_children("*", "AnimatedSprite2D", true, false)
	if sprites.size() > 0:
		sprites[0].flip_h = mirar_izquierda

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(player7, "position:x", destino_x, 0.4)
	tween.tween_callback(func():
		en_movimiento = false
		callback.call()
	)

func _al_llegar_productos() -> void:
	if productos_restantes > 0:
		tiene_producto = true
		productos_total.visible = true
		_actualizar_productos_visuales()
		_actualizar_ui()


func _al_llegar_camion() -> void:
	tiene_producto = false
	productos_restantes -= 1
	productos_total.visible = false
	_actualizar_ui()
	_actualizar_productos_visuales()
	
	var entregados = total_productos - productos_restantes - 1
	if entregados >= 0 and entregados < productos_entregados_nodos.size():
		productos_entregados_nodos[entregados].visible = true
	
	if productos_restantes <= 0:
		_fin_juego(true)

#ui
func _actualizar_ui() -> void:
	label_p_restantes.text = "Productos restantes: %d" % productos_restantes

func _actualizar_productos_visuales() -> void:
	for i in range(productos_nodos.size()):
		productos_nodos[i].visible = i < productos_restantes

func _tiempo_agotado() -> void:
	_fin_juego(false)

func _fin_juego(gano: bool) -> void:
	juego_activo = false
	timer_juego.stop()
	label_resultados.visible = true
	if gano:
		await get_tree().create_timer(2.0).timeout
		label_resultados.text = "¡Entregaste todos los productos!"
		get_tree().change_scene_to_file("res://nivel8/juego_8.tscn")
	else:
		await get_tree().create_timer(1.0).timeout
		label_resultados.text = "¡Perdiste!" + "\n" + "se termino el tiempo"
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://game_over.tscn")
	#await get_tree().create_timer(2.0).timeout
	#get_tree().change_scene_to_file("res://nivel8/nivel8.tscn")
