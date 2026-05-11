extends Control


func _on_button_pressed() -> void:
	# se puede elegir otra escena
	get_tree().change_scene_to_file("res://menú_principal.tscn")
