extends CanvasLayer

@onready var etiqueta_vidas = $Control/Label

func _ready():
	# Conectamos la señal del GameManager para actualizar la UI automáticamente
	GameManager.connect("vidas_actualizadas", _on_vidas_actualizadas)
	# Mostramos las vidas iniciales al cargar
	_on_vidas_actualizadas(GameManager.total_vidas)

func _on_vidas_actualizadas(vidas: int):
	etiqueta_vidas.text = "Vidas: " + str(vidas)
