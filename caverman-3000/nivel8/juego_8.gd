extends Node2D
#puse onreadys, para que sea facil modificar y testear
@onready var auto1 = $auto1
@onready var auto2 = $auto2
@onready var player1 = $player8
@onready var area_player = $player8/Areaplayer
@onready var label_resultado = $UI/VBoxContainer/LabelResultado

var paso: float = 40.0
var meta_x: float = 520.0
var velocidad_auto1: float = 850.0 #iniclamente en 200
var velocidad_auto2: float = -500.0 #incialmente en -180
var juego_activo: bool = true

var carril_1_y: float
var carril_2_y: float
var vereda_inicio_y: float
var fuera_de_pantalla_y: float = -80.0
var carril_actual: int = 0

var en_movimiento: bool = false


func _ready() -> void:
	
	carril_1_y = max(auto1.position.y, auto2.position.y)
	carril_2_y = min(auto1.position.y, auto2.position.y)
	
	vereda_inicio_y = carril_1_y + 115.0
	player1.position.y = vereda_inicio_y
	auto1.position.x = -100.0
	auto2.position.x = 1252.0
	
	label_resultado.visible = false
	
	auto1.area_entered.connect(_en_colision)
	auto2.area_entered.connect(_en_colision)

func _en_colision(area):
	if area == area_player and juego_activo:
		_fin_juego(false)


func _process(delta: float) -> void:
	if !juego_activo:
		return
	
	auto1.position.x += velocidad_auto1 * delta
	auto2.position.x += velocidad_auto2 * delta
	
	if auto1.position.x > 1252:
		auto1.position.x = -10
	if auto2.position.x < -100:
		auto2.position.x = 1152

func _input(event: InputEvent) -> void:
	if !juego_activo:
		return
	if en_movimiento:
		return
	if event.is_action_pressed("ui_up"):
		_avanzar_carril()

func _tiempo_agotado():
	_fin_juego(false)

func _avanzar_carril():
	carril_actual += 1
	en_movimiento = true
	
	var destino_y: float
	
	match carril_actual:
		1:
			destino_y = carril_1_y
			_mover_player(destino_y, false)
		2:
			destino_y = carril_2_y
			_mover_player(destino_y, false)
		3:
			_mover_player(fuera_de_pantalla_y, true)
			
func _mover_player(destino_y: float, es_victoria: bool):
	#implementacion de tween a medias
	var tween = create_tween()
	tween.tween_property(player1, "position:y", destino_y, 0.15)
	tween.tween_callback(func():
		en_movimiento = false
		if es_victoria:
			_fin_juego(true)
)

func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()

func _fin_juego(gano: bool):
	juego_activo = false
	
	label_resultado.visible = true
	# colocaria una funcion de victoria de ser posible
	if gano:
		$eventos.nivel_ganado()
		
		label_resultado.text = "¡Llegaste por suerte y ganaste!"
		label_resultado.visible = false
		$UI.visible = false
		$HUDV.visible = false
		#.visible = false
		await get_tree().create_timer(1.5).timeout
		#get_tree().change_scene_to_file("res://menú_principal.tscn")
	else:
		label_resultado.text = "¡Te atropellaron, no se logró!"
		#await get_tree().create_timer(1.5).timeout
		get_tree().paused = true
		await get_tree().create_timer(2.0).timeout
	# Esta función se ejecuta cuando el tiempo llega a cero
	# aca puedo cambiar de escena o activar Game Over
		$eventos._on_tiempo_juego_timeout()
	#esto faltaba para que reinicie el nivel y funcione bien
	#get_tree().change_scene_to_file("res://game_over.tscn")
	#await get_tree().create_timer(2.0).timeout
	#get_tree().change_scene_to_file("res://game_over.tscn")
