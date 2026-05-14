extends Area2D


@export var clean_time := 1.0

var clean_progress := 0.0

func clean(delta):
	clean_progress += delta
	
	modulate.a = 1.0 - (clean_progress / clean_time)
	if clean_progress >= clean_time:
		queue_free()
