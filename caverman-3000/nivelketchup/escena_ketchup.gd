extends Node2D

@export var hits_required : int = 20

var current_hits : int = 0
var exploded : bool = false


func _ready():
	$Ketchup/AnimatedSprite2D.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	if exploded:
		go_to_victory()

func _process(delta):
	if Input.is_action_just_pressed("hit") and not exploded:
		#$Ketchup/AnimatedSprite2D.play("idle")
		register_hit()

func register_hit():
	current_hits += 1
	print("Golpes:", current_hits)
	$Hand/AnimatedSprite2D.play("shake")
	$Ketchup/AnimatedSprite2D.play("hit")
	
	if current_hits >= hits_required:
		
		explode()
		

func explode():
	exploded = true
	$Ketchup/AnimatedSprite2D.play("explode")


func go_to_victory():
	var eventos = get_node_or_null("eventos")
	if eventos:
		eventos.nivel_ganado()
	get_tree().change_scene_to_file("res://nivel7/juego_7.tscn")


func _on_reiniciar_pressed() -> void:
	# Quita la pausa por si el juego estaba pausado al perder
	get_tree().paused = false 
	# Recarga el nivel actual
	get_tree().reload_current_scene()
