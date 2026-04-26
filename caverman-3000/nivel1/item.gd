extends Area2D

@onready var animacion = $Animated

signal recolectar_items


func _ready():
	animacion.play("idle")

func _on_body_entered(body):
	if body.is_in_group("cavernicola"):#referencia de que grupo entra en contacto con la moneda
		print("moneda")
		animacion.play("recojido")
		await(animacion.animation_finished)
		emit_signal("recolectar_items")
		queue_free()#se destruye el item(moneda)
	#get_tree().change_scene_to_file("res://menú.tscn")
	
	
