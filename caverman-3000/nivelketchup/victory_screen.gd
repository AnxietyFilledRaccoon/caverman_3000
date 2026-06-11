extends Control

func _ready():
	scale = Vector2(0.1, 0.1)
	modulate.a = 0.0
	
	var tween = create_tween()
	
	tween.parallel().tween_property(self, "scale", Vector2(1, 1), 0.8)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
		
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.2)
	#colocar un timer para pasar a otra escena
	TransicionManager.cambiar_nivel("Reponer", "Usa Cruceta","")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://nivel7/juego_7.tscn")
