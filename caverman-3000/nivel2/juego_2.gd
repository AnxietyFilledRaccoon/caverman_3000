extends Node2D

var productos = 5
@onready var mano = $mano 
@onready var texto = $CanvasLayer/Cproducto
var event
signal borrate
var producto_actual : Area2D = null

func _ready() -> void:
	texto.text = "productos: " + str(productos)
	
func _on_producto_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Ítem agarrado")
		productos -=1
		producto_actual.recoger()
		texto.text = "productos: " + str(productos)
		emit_signal("borrate")
		producto_actual.queue_free()
		if productos <= 0:
			finalizar()
		print(productos)
	
	
func _on_mano_area_entered(area: Area2D) -> void:
	if area.is_in_group("productos"):
		producto_actual = area
		
		
func finalizar():
	
		get_tree().change_scene_to_file("res://menú_principal.tscn")
