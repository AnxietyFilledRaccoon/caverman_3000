extends Node2D

var items = 0

func _on_moneda_recolectar_items() -> void:
	items +=1
	get_node("CanvasLayer/TextoItems").text = "Items: " + str(items)
	
	
func victoria():
	pass
