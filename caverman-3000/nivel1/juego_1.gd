extends Node2D

var item = 0

func _on_moneda_recolectar_items() -> void:
	item +=1
	get_node("CanvasLayer/items").text = "Items: " + str(item)
	
	
