extends Area2D

class_name items
signal recolectar_items

@export var textura : Texture2D
@export var tamaño = 1.0 #modifico el tamaño individual por inspector

func _ready():
	$Sprite2D.texture = textura
	scale = Vector2(tamaño, tamaño)


func _on_body_entered(body):
	if body.is_in_group("cavernicola"):#referencia de que grupo entra en contacto con la moneda
	
		get_parent().item +=1
		
		emit_signal("recolectar_items")
		queue_free()#se destruye el item(moneda)
	#get_tree().change_scene_to_file("res://menú.tscn")
	

	
	
