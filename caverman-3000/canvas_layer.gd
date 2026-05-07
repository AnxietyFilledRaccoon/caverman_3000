extends CanvasLayer

func _ready() -> void:
	$Cproducto.text = "productos: " + str(get_parent().productos)
	
