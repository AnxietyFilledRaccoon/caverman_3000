extends Node2D

@export var hits_required : int = 20

var current_hits : int = 0
var codeados : bool = false


func _ready():
	$personaje.animation_finished.connect(_on_animation_finished)
	print($personaje)
	print($computadora)

func _on_animation_finished():
	if codeados:
		go_to_victory()

func _process(delta):
	if Input.is_action_just_pressed("hit") and not codeados:
		register_hit()
		animated_sprites(true)
	if Input.is_action_just_released("hit"):
		animated_sprites(false)

func register_hit():
	current_hits += 1
	print("Golpes:", current_hits)
	
func animated_sprites(active: bool):
	if active:
		$personaje.frame = 1
		$computadora.frame = 1
	else:
		$personaje.frame = 0
		$computadora.frame = 0

	if current_hits >= hits_required:
		codeado()

func codeado():
	codeados = true
	$computadora.play("win")
	
func go_to_victory():
	var eventos = get_node_or_null("eventos")
	if eventos:
		eventos.nivel_ganado()
		await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://nivel_Programacion/escena_Programacion_Victoria.tscn")
	
func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
