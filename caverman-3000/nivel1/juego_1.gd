extends Node2D

var item = 0

func _on_moneda_recolectar_items() -> void:
	item +=1
	get_node("CanvasLayer/TextoItems").text = "Items: " + str(item)
	
	
func victoria():
	pass
