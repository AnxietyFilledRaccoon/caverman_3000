extends Area2D

class_name producto

signal item_recogido
@export var textura : Texture2D
@export var tamaño = 1.0

func _ready():
	$productos.texture = textura
	scale = Vector2(tamaño, tamaño)

func recoger():
	#print("item")
	# Aquí puedes añadir sonido o animaciones
	emit_signal("item_recogido")
	#queue_free() # Elimina el ítem de la escena


func _on_juego_2_borrate() -> void:
	recoger()
