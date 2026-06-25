extends Node2D

@onready var montoncito: AnimatedSprite2D = $Montoncito
@onready var personaje_anim: AnimatedSprite2D = $Personaje/Animacion
@onready var eventos = $eventos

@export var total_pulsaciones: int = 20

# Cuántas paladas visuales puede guardar si el jugador spamea.
# Si lo ponés muy alto, la animación queda "atrasada".
@export var max_paladas_buffer: int = 2

@export var ruta_siguiente_nivel: String = ""
@export var imagen_controles: Texture2D

var pulsaciones: int = 0
var juego_activo: bool = true

var animando_palada: bool = false
var paladas_pendientes: int = 0

var estados_montoncito = ["vacio", "poco", "medio", "lleno"]


func _ready() -> void:
	if personaje_anim.sprite_frames:
		if personaje_anim.sprite_frames.has_animation("idle"):
			personaje_anim.sprite_frames.set_animation_loop("idle", true)
			personaje_anim.play("idle")

		if personaje_anim.sprite_frames.has_animation("palada"):
			personaje_anim.sprite_frames.set_animation_loop("palada", false)

	if montoncito.sprite_frames and montoncito.sprite_frames.has_animation("vacio"):
		montoncito.play("vacio")

	if not personaje_anim.animation_finished.is_connected(_on_personaje_animation_finished):
		personaje_anim.animation_finished.connect(_on_personaje_animation_finished)


func _input(event: InputEvent) -> void:
	if !juego_activo:
		return

	if event.is_action_pressed("ui_accept"):
		# Esto evita que mantener apretado espacio cuente como mil paladas.
		# Si querés que mantener apretado también cuente, borrá estas 2 líneas.
		if event is InputEventKey and event.is_echo():
			return

		_registrar_palada()


func _registrar_palada() -> void:
	pulsaciones += 1

	_actualizar_montoncito()
	_pedir_animacion_palada()

	if pulsaciones >= total_pulsaciones:
		_fin_juego(true)


func _pedir_animacion_palada() -> void:
	if !personaje_anim.sprite_frames:
		return

	if !personaje_anim.sprite_frames.has_animation("palada"):
		return

	# Si no está animando, reproduce la palada.
	if !animando_palada:
		animando_palada = true
		personaje_anim.play("palada")
		return

	# Si ya está animando y el jugador spamea, guardamos algunas paladas visuales.
	paladas_pendientes = min(paladas_pendientes + 1, max_paladas_buffer)


func _on_personaje_animation_finished() -> void:
	if personaje_anim.animation != "palada":
		return

	if paladas_pendientes > 0 and juego_activo:
		paladas_pendientes -= 1
		personaje_anim.play("palada")
	else:
		animando_palada = false

		if personaje_anim.sprite_frames and personaje_anim.sprite_frames.has_animation("idle"):
			personaje_anim.play("idle")


func _actualizar_montoncito() -> void:
	var progreso := float(pulsaciones) / float(total_pulsaciones)

	var estado := 0

	if progreso >= 0.75:
		estado = 3
	elif progreso >= 0.50:
		estado = 2
	elif progreso >= 0.25:
		estado = 1
	else:
		estado = 0

	var nombre_animacion = estados_montoncito[estado]

	if montoncito.sprite_frames and montoncito.sprite_frames.has_animation(nombre_animacion):
		montoncito.play(nombre_animacion)


func _fin_juego(gano: bool) -> void:
	juego_activo = false
	paladas_pendientes = 0

	if gano:
		eventos.nivel_ganado()

		await get_tree().create_timer(1.0).timeout
		
		TransicionManager.cambiar_nivel("Malavares",
		preload("res://asets/Fondos y otras escenas/Botones/BarraEspaciadora.png"),
		"")# puedo agregar en el espacio libre la siguiente pantalla
		#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://nivelmalabares/juegomalabares.tscn")
				
				
				
				
	else:
				await get_tree().create_timer(2.0).timeout
				get_tree().change_scene_to_file("res://game_over.tscn")
				get_tree().change_scene_to_file(ruta_siguiente_nivel)

func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
