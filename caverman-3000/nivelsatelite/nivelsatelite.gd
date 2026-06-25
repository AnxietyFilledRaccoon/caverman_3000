extends Node2D

@onready var fondo: Sprite2D = $Fondo
@onready var caja = $Caja
@onready var cavernicola: AnimatedSprite2D = $Cavernicola
@onready var publicidades: Node2D = $Publicidades

@onready var creditos: RichTextLabel = $Control/CenterContainer/Creditos
@onready var mensajes: VBoxContainer = $Control/CenterContainer/Mensajes
@onready var fade: ColorRect = $CanvasLayer/Fade

@export var velocidad_creditos: float = 35.0
@export var max_golpes_buffer: int = 2
@export var fuerza_shake_caja: float = 8.0
@export var duracion_shake: float = 0.08

var juego_activo: bool = true
var golpeando: bool = false
var golpes_pendientes: int = 0
var cantidad_golpes: int = 0

var mensajes_agradecimiento := [
	"Gracias a quienes respondieron el formulario.",
	"Gracias por jugar hasta el final.",
	"Gracias por acompañar el proyecto.",
	"Gracias a quienes probaron el juego.",
	"Gracias por ayudarnos a terminarlo.",
	"Fin del recorrido."
]

var indice_mensaje: int = 0


func _ready() -> void:
	fade.color = Color.BLACK
	fade.modulate.a = 0.0

	if cavernicola.sprite_frames:
		if cavernicola.sprite_frames.has_animation("idle"):
			cavernicola.sprite_frames.set_animation_loop("idle", true)
			cavernicola.play("idle")

		if cavernicola.sprite_frames.has_animation("golpear"):
			cavernicola.sprite_frames.set_animation_loop("golpear", false)

	if not cavernicola.animation_finished.is_connected(_on_cavernicola_animation_finished):
		cavernicola.animation_finished.connect(_on_cavernicola_animation_finished)

	_preparar_creditos()


func _process(delta: float) -> void:
	if !juego_activo:
		return

	creditos.position.y -= velocidad_creditos * delta

	if creditos.position.y + creditos.size.y < -50:
		_terminar_escena()


func _input(event: InputEvent) -> void:
	if !juego_activo:
		return

	if event is InputEventKey and event.is_echo():
		return

	if event.is_action_pressed("ui_accept"):
		_registrar_golpe()


func _registrar_golpe() -> void:
	cantidad_golpes += 1

	_pedir_animacion_golpe()
	_shake_caja()

	if cantidad_golpes % 3 == 0:
		_mostrar_mensaje()

	if cantidad_golpes % 2 == 0:
		_crear_publicidad()


func _pedir_animacion_golpe() -> void:
	if !cavernicola.sprite_frames:
		return

	if !cavernicola.sprite_frames.has_animation("golpear"):
		return

	if !golpeando:
		golpeando = true
		cavernicola.play("golpear")
	else:
		golpes_pendientes = min(golpes_pendientes + 1, max_golpes_buffer)


func _on_cavernicola_animation_finished() -> void:
	if cavernicola.animation != "golpear":
		return

	if golpes_pendientes > 0 and juego_activo:
		golpes_pendientes -= 1
		cavernicola.play("golpear")
	else:
		golpeando = false

		if cavernicola.sprite_frames and cavernicola.sprite_frames.has_animation("idle"):
			cavernicola.play("idle")


func _shake_caja() -> void:
	var posicion_original = caja.position

	var tween = create_tween()
	tween.tween_property(caja, "position", posicion_original + Vector2(randf_range(-fuerza_shake_caja, fuerza_shake_caja), 0), duracion_shake)
	tween.tween_property(caja, "position", posicion_original, duracion_shake)


func _crear_publicidad() -> void:
	var label := Label.new()
	label.text = "SALE"
	label.position = caja.position + Vector2(randf_range(-20, 20), randf_range(-60, -20))
	label.scale = Vector2(1.4, 1.4)
	label.z_index = 50

	publicidades.add_child(label)

	var destino = label.position + Vector2(randf_range(80, 180), randf_range(-120, -40))

	var tween = create_tween()
	tween.tween_property(label, "position", destino, 1.2)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 1.2)
	tween.tween_callback(label.queue_free)


func _mostrar_mensaje() -> void:
	if indice_mensaje >= mensajes_agradecimiento.size():
		return

	var label := Label.new()
	label.text = mensajes_agradecimiento[indice_mensaje]
	label.modulate.a = 0.0
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	mensajes.add_child(label)

	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.4)

	indice_mensaje += 1


func _preparar_creditos() -> void:
	creditos.text = """
[center][b]CRÉDITOS[/b][/center]

Programación
Programador Lider
Leonardo Rajoy
Programador Secundario

Arte
Felipe Dedominici

Diseño
Lucas Hildebrand

Agradecimientos
A quienes respondieron el formulario
A quienes probaron el juego
A quienes acompañaron el desarrollo

Gracias por jugar
"""

	creditos.position.y = get_viewport_rect().size.y + 50


func _terminar_escena() -> void:
	juego_activo = false

	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 2.0)
	tween.tween_callback(func():
		get_tree().change_scene_to_file("res://menú_principal.tscn")
)
