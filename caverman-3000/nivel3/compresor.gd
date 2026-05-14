extends CharacterBody2D
@export var speed := 300.0
@export var rotation_speed := 2.0
@onready var chorro_de_agua = $"chorro de agua"
@onready var linea_de_agua = $"linea de agua"
@onready var nozzle = $Nozzle



func _process(delta):
	if Input. is_action_pressed("apuntar izquierda"):
		rotation -= rotation_speed * delta
	if Input. is_action_just_pressed("apuntar derecha"):
		rotation += rotation_speed * delta
	update_water()

func update_water():
	chorro_de_agua.global_position = nozzle.global_position
	chorro_de_agua.global_rotation = global_rotation
	var end_point = chorro_de_agua. target_position

	
	if chorro_de_agua. is_colliding():
		var collider = chorro_de_agua.get_collider()
		if collider.is_in_group("mancha"):
			collider.clean(get_process_delta_time())
			
		end_point = to_local(chorro_de_agua.get_collision_point())
		
	linea_de_agua.clear_points()
	linea_de_agua.add_point(to_local(nozzle.global_position))
	linea_de_agua.add_point(end_point)			
