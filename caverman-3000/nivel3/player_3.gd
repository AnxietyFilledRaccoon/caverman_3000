extends CharacterBody2D

@export var move_speed = 200
@onready var animacion = $jugador
var mirando_derecha = true
var screen_size
var items_recolectados = 0
var meta_items = 5
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
	move_and_slide()
	

	
func animaciones():
	if velocity.x:
		animacion.play("pedalearx")
			
	else:
		animacion.play("idle")

		if velocity.y:
			animacion.play("pedalearup")
			if velocity.y > 0:
				animacion.play("pedaleardown")
		

func movimiento_X():
	# Obtiene la dirección basada en las acciones (por defecto: ui_left, ui_right, ui_up, ui_down)
	var direction = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
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
	$"../eventos".nivel_ganado()

	#aca hay que sumar plata al score
	##pasar a otra escena, menu o pantalla
	TransicionManager.cambiar_nivel(
	"Reponer",
	preload("res://asets/Fondos y otras escenas/Botones/Cruceta2.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://nivel7/juego_7.tscn")


func _on_item_recolectar_items() -> void:
	recoger_items()
