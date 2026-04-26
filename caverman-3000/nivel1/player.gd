extends CharacterBody2D

@export var move_speed = 100
@onready var animacion = $jugador
var mirando_derecha = true
var screen_size



func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	

		
	move_and_slide()
	movimiento_X()
	animaciones()
	
	
func animaciones():
	if velocity.x:
		animacion.play("caminar")
	else:
		animacion.play("idle")

func movimiento_X():
	# Obtiene la dirección basada en las acciones (por defecto: ui_left, ui_right, ui_up, ui_down)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Aplica la velocidad a la dirección
	velocity = direction * move_speed
	
		
	if( mirando_derecha and velocity.x < 0) or (not mirando_derecha and velocity.x > 0 ):
		scale.x *= -1
		mirando_derecha = not mirando_derecha
		
		
	
