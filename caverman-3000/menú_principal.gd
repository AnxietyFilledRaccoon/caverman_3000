extends Control


func _on_play_pressed() -> void:
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Opening/opening.tscn")

func _on_opcion_pressed() -> void:
	pass # Replace with function body.

func _on_quitar_pressed() -> void:
	get_tree().quit()

# Hice esta funcion que basicamente pasaria al nivel del ketchup pero no quiero arruinarte el codigo metiendo mano
# asi que usala cuando sientas que sea correcto, seria tecnicamente cuando termine el nivel 2.	
#func go_to_next_level():
#	get_tree().change_scene_to_file("res://nivelketchup/escena_ketchup.tscn")
