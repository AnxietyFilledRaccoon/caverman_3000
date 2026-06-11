extends Control


func _on_play_pressed() -> void:
	await get_tree().create_timer(1.0).timeout 
	TransicionManager.cambiar_nivel(
	"INTRO",
	"Usa Cruceta","")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Nivel0/nivelIntro.tscn")
	#aca colocar al nivel 1

func _on_opcion_pressed() -> void:
	pass # Replace with function body.

func _on_quitar_pressed() -> void:
	get_tree().quit()
