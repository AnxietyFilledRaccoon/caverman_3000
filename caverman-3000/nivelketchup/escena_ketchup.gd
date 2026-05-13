extends Node2D

@export var hits_required : int = 10

var current_hits : int = 0
var exploded : bool = false

func _ready():
	$Ketchup/AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "explode":
		go_to_victory()

func _process(delta):
	if Input.is_action_just_pressed("hit") and not exploded:
		register_hit()

#Funciones

func register_hit():
	
	current_hits += 1
	print("Golpes:", current_hits)
	
	$Hand/AnimationPlayer.play("hit")
	$Ketchup/AnimationPlayer.play("shake")
	
	if current_hits >= hits_required:
		explode()

func explode():
	exploded = true
	$Ketchup/AnimationPlayer.play("explode")

func go_to_victory():
	get_tree().change_scene_to_file("res://VictoryScreen.tscn")
