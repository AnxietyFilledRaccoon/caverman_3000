extends Node2D
#Monton de tierra
@onready var montoncito = $Montoncito
@onready var personaje_anim = $Personaje/Animacion

#Gameplay

var pulsaciones: int = 0
var total_pulsaciones: int = 20
var juego_activo: bool = true

#Animacion del monton de tierra
var estados_montoncito = ["vacio", "poco", "medio", "lleno"]

func _ready() -> void:
	montoncito.play("vacio")
	

func _input(event: InputEvent) -> void:
	if !juego_activo:
		return
	if event.is_action_pressed("ui_accept"):
		_palada()

func _palada():
	
	pulsaciones += 1
	
	personaje_anim.play("palada")
	
	var estado = min(pulsaciones / 4, 3)
	montoncito.play(estados_montoncito[estado])
	if pulsaciones >= total_pulsaciones:
		_fin_juego(true)

func _fin_juego(gano: bool):
	juego_activo = false
	if gano:
		$eventos.nivel_ganado()
	#else:
		#derrota
		#$eventos._on_tiempo_juego_timeout()
	pass
