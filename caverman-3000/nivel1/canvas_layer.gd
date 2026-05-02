extends CanvasLayer

func _process(_delta):
	$TextoItems.text = str(get_parent().item)
