extends Control


func _ready():
	$AnimationPlayer.play("alquiler")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://mapa.tscn")
