extends Node

func _ready() -> void:
	pass
	
func transition_to_game():
	get_tree().change_scene_to_file("res://scenes/interim.tscn")
