extends CanvasLayer

@onready var vida = [$Control/HBoxContainer/vida1, $Control/HBoxContainer/vida2, $Control/HBoxContainer/vida3]

func _ready():
	# Conectamos la señal del GameManager para actualizar la UI automáticamente
	GameManager.connect("vidas_actualizadas", _on_vidas_actualizadas)
	# Mostramos las vidas iniciales al cargar
	_on_vidas_actualizadas(GameManager.total_vidas)

func _on_vidas_actualizadas(vidas: int):
	for i in range(vida.size()):

		if i < vidas:
			vida[i].visible = true
		else:
			vida[i].visible = false
