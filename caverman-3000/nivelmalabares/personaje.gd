extends Node2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")

func hacer_malabar():

	anim.stop()

	anim.frame = 0

	anim.play("malabares")

func terminar():

	anim.stop()

	anim.play("idle")
