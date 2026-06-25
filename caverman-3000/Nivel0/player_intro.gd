extends CharacterBody2D
@export var move_speed = 200
#animacion del jugador
@onready var animacion = $jugador
#animacion de npc's
@onready var npc1 = $"../SBnpc1/ASnpc1"
@onready var npc2 = $"../SBnpc2/ASnpc2"
@onready var npc3 = $"../SBnpc3/ASnpc3"

var mirando_derecha = true
var screen_size
var items_recolectados = 0
var meta_items = 4
var gravity = 1000


func _ready():
	screen_size = get_viewport_rect().size
	items_recolectados = 0
	
	if npc1:
		npc1.play("idle")
	if npc2:
		npc2.play("idle")
	if npc3:
		npc3.play("idle")


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
		animacion.play("caminarX")
			
	else:
		animacion.play("idle")

		if velocity.y:
			animacion.play("caminarup")
			if velocity.y > 0:
				animacion.play("caminardown")
		

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
		#llama a la metodo que actualiza a los npcs(animacion)
		_actualizar_npcs()
		
		if items_recolectados >= meta_items:
			ganar_juego() # aca puedo emitir una señal que llame al ganar juego dew gestor de eventos
		

func _actualizar_npcs() -> void:
	if items_recolectados == 1:
		_cambiar_npc_a_globo(npc1)
	elif items_recolectados == 2:
		_cambiar_npc_a_globo(npc2)
	elif items_recolectados == 3:
		_cambiar_npc_a_globo(npc3)
	pass

func _cambiar_npc_a_globo(npc: AnimatedSprite2D) -> void:
	if npc == null:
		return
	
	if npc.sprite_frames and npc.sprite_frames.has_animation("AnconGlobo"):
		npc.play("AnconGlobo")
		print("Si tengo animacion mira crack")
	else:
		print("No encontre animacion")

func ganar_juego(): #esto deberia estar en un gestor de eventos

	#aca hay que sumar plata al score
	##pasar a otra escena, menu o pantalla
	TransicionManager.cambiar_nivel(
	"Mapa",
	preload("res://asets/Fondos y otras escenas/Botones/Mouse1.png"),"")# puedo agregar en el espacio libre la siguiente pantalla
	#pero decidi que me de unos segundos antes de ejecutar el siguiente nivel, por eso lo hidce asi
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://mapa.tscn")
	
	


func _on_item_recolectar_items():
	print("funciona")
	recoger_items()
