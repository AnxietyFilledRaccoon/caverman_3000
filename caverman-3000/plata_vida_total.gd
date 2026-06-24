extends Control

@onready var label_platita = $VBoxContainer/HBoxContainer1/LabelPlatita
@onready var tarjetas = [
	$VBoxContainer/HBoxContainer2/Tarjeta1,
	$VBoxContainer/HBoxContainer2/Tarjeta2,
	$VBoxContainer/HBoxContainer2/Tarjeta3
]

func _ready():
	$Fondo.size = get_viewport().get_visible_rect().size
	$Fondo.position = Vector2.ZERO
	
	label_platita.text = "PLATITA GANADA: $%d" % GameManager.platita_total
	for i in range(tarjetas.size()):
		tarjetas[i].visible = i < GameManager.total_vidas


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mapa.tscn")
