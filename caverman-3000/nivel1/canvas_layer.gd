extends CanvasLayer
	
func _process(_delta):
	$items.text = "Residuos : " + str(get_parent().item)
