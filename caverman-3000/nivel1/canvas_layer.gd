extends CanvasLayer
	
func _process(_delta):
	$items.text = "basurita : " + str(get_parent().item)
