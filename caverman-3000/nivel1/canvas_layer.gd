extends CanvasLayer
	
func _process(_delta):
	
	$items.text = "volantes: " + str(get_parent().item)
