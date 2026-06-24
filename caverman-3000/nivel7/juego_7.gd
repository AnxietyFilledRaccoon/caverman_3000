extends Node2D
#editor de nodos
@onready var anim_player7: AnimatedSprite2D = $Playerlvl7/AnimationPlayer
@export var duracion_movimiento_player: float = 0.4
@onready var player7 = $Playerlvl7
@onready var productos = $Estanteria/Productos
@onready var camion = $Camion
@onready var label_p_restantes = $Ui/Control/LabelPRestantes
@onready var label_resultados = $Ui/Control/LabelResultado
@onready var punto_spawn = $Puntos/PuntoSpawn
@onready var punto_caja = $Puntos/PuntoCaja
@onready var punto_camion = $Puntos/PuntoCamion
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
	
	player7.global_position = punto_spawn.global_position
	player7.z_index = 20

	if anim_player7:
		anim_player7.z_index = 21
		anim_player7.visible = true

		if anim_player7.sprite_frames:
			if anim_player7.sprite_frames.has_animation("idle"):
				anim_player7.sprite_frames.set_animation_loop("idle", true)
				anim_player7.play("idle")

			if anim_player7.sprite_frames.has_animation("caminar"):
				anim_player7.sprite_frames.set_animation_loop("caminar", true)

	label_resultados.visible = false
	productos_total.visible = false

	_actualizar_ui()
	_actualizar_productos_visuales()



func _process(_delta: float) -> void:
	if !juego_activo:
		return
	

func _input(event: InputEvent) -> void:
	#Movimvento del jugador con las flechitas, solo si el juego esta activo y el jugador no esta en movimiento
	if !juego_activo:
		return

	if en_movimiento:
		return

	if event is InputEventKey and event.is_echo():
		return

	if event.is_action_pressed("Izquierda"):
		if !tiene_producto:
			_mover_player(punto_caja.global_position.x, _al_llegar_productos, false)

	if event.is_action_pressed("Derecha"):
		if tiene_producto:
			_mover_player(punto_camion.global_position.x, _al_llegar_camion, false)

func _mover_player(destino_x, callback, mirar_izquierda = false) -> void:
	en_movimiento = true

	var va_hacia_izquierda = destino_x < player7.global_position.x

	if anim_player7:
		anim_player7.flip_h = va_hacia_izquierda

		if anim_player7.sprite_frames and anim_player7.sprite_frames.has_animation("caminar"):
			anim_player7.play("caminar")

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(player7, "global_position:x", destino_x, 0.45)

	tween.tween_callback(func():
		en_movimiento = false

		if anim_player7:
			if anim_player7.sprite_frames and anim_player7.sprite_frames.has_animation("idle"):
				anim_player7.play("idle")

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

func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()

func _fin_juego(gano: bool) -> void:
	juego_activo = false
	label_resultados.visible = true
	if gano:
		$eventos.nivel_ganado()
		await get_tree().create_timer(2.0).timeout
		label_resultados.text = "¡Entregaste todos los productos!"
		
		TransicionManager.cambiar_nivel(
		"Cruzar Paquete",
		preload("res://asets/Fondos y otras escenas/Botones/Cruceta1.png"),"")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://nivel8/juego_8.tscn")
	else:
		await get_tree().create_timer(1.0).timeout
		label_resultados.text = "¡Perdiste!" + "\n" + "se termino el tiempo"
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://game_over.tscn")
	#await get_tree().create_timer(2.0).timeout
	#get_tree().change_scene_to_file("res://nivel8/nivel8.tscn")
