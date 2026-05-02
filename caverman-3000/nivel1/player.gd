extends CharacterBody2D

@export var move_speed = 200
@onready var animacion = $jugador
var mirando_derecha = true
var screen_size
var items_recolectados = 0
var meta_items = 4
var gravity = 1000


func _ready():
	screen_size = get_viewport_rect().size
	items_recolectados = 0
	


func _physics_process(delta):
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if not is_on_floor():
		velocity.y += gravity + delta

	movimiento_X()
	animaciones()
	#recoger_items()
	move_and_slide()
	

	
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
	
	
func recoger_items():
	
		items_recolectados += 1
		print("items:", items_recolectados)
		if items_recolectados >= meta_items:
			ganar_juego() # aca puedo emitir una señal que llame al ganar juego dew gestor de eventos
		
func ganar_juego(): #esto deberia estar en un gestor de eventos
	print("ganaste")
	##pasar a otra escena, menu o pantalla
	get_tree().change_scene_to_file("res://menú_principal.tscn")
		
	


func _on_moneda_recolectar_items() -> void:
	recoger_items()
