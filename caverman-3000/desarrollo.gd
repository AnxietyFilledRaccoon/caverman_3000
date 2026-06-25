extends Control

func _ready() -> void:
	#$AnimationPlayer.play("introduccion")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Opening/opening.tscn")

func _input(event):
	await get_tree().create_timer(1.0).timeout
	# Permitir saltar con cualquier tecla o clic
	if event is InputEventKey or event is InputEventMouseButton:
		finalizar_intro()


func finalizar_intro():
	
	print(" fin")
	get_tree().change_scene_to_file("res://Opening/opening.tscn")
	#aca colocar que se dirija al menu de juego
