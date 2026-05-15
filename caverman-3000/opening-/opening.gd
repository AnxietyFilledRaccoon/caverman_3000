extends Control

# Ruta a la siguiente escena (menú o juego)
var escena_juego = ""

func _ready():
	$AnimationPlayer.play("introduccion")
	# Conectar la señal al finalizar
	#$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _input(event):
	# Permitir saltar con cualquier tecla o clic
	if event is InputEventKey or event is InputEventMouseButton:
		finalizar_intro()

func _on_animation_finished(anim_name):
	finalizar_intro()

func finalizar_intro():
	
	print(" fin")
	#get_tree().change_scene_to_file(escena_juego)
