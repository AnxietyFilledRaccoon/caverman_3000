extends Node2D

func _process(delta):
	
	if get_tree(). get_nodes_in_group("mancha").size() == 0:
		print("nivel completado")
