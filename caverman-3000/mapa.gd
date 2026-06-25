extends Control






func _on_fuerza_pressed() -> void:
	await get_tree().create_timer(0.2).timeout 
	TransicionManager.cambiar_nivel(
	"Preparar",
	preload ("res://asets/Fondos y otras escenas/Botones/BarraEspaciadora3.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://nivelketchup/escena_ketchup.tscn")
	#aca colocar al nivel 1


func _on_cliente_pressed() -> void:
	await get_tree().create_timer(0.2).timeout 
	TransicionManager.cambiar_nivel(
	"Ordenar",
	preload ("res://asets/Fondos y otras escenas/Botones/Mouse1.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://nivel2/juego_2.tscn")
	#aca colocar al nivel 1


func _on_tecno_pressed() -> void:
	await get_tree().create_timer(0.2).timeout 
	TransicionManager.cambiar_nivel(
	"Recolectar",
	preload ("res://asets/Fondos y otras escenas/Botones/Cruceta1.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://nivel1/juego1.tscn")
	#aca colocar al nivel 1


func _on_menuprincipal_pressed() -> void:
	await get_tree().create_timer(0.2).timeout 
	TransicionManager.cambiar_nivel(
	"",
	preload("res://asets/Fondos y otras escenas/Botones/Mouse2.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menú_principal.tscn")
	#aca colocar al nivel 1
	
