extends Area2D

class_name items
signal recolectar_items
@onready var animacion = $Animated


func _ready():
	animacion.play("idle")

func _on_body_entered(body):
	if body.is_in_group("cavernicola"):#referencia de que grupo entra en contacto con la moneda
	
		get_parent().item +=1
		animacion.play("recojido")
		#await(animacion.animation_finished)
		finalizar()
		emit_signal("recolectar_items")
		queue_free()#se destruye el item(moneda)
	#get_tree().change_scene_to_file("res://menú.tscn")
	
func finalizar():
	await(animacion.animation_finished)
	
	
	
