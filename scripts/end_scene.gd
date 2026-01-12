extends TextureRect

@onready var variable_header : Label = $VBoxContainer/Header2
@onready var score_label : Label = $VBoxContainer/ScoreLabel

@onready var transition_animation_player : AnimationPlayer = $BlackFadeTransition/AnimationPlayer

func _ready() -> void:
	score_label.text = str(GlobalVars.final_score)
	
	if GlobalVars.final_score >= 25:
		variable_header.text = "SUCCESS!!"
		variable_header.self_modulate = Color.DEEP_SKY_BLUE
		texture = load("res://textures/HLW_Stage.png")
	else:
		variable_header.text = "FAILURE..."
		variable_header.self_modulate = Color.FIREBRICK
		texture = load("res://textures/HLW_OfficeInterior.png")

func play_retry_transition():
	transition_animation_player.play("RetryTransition")

func retry():
	get_tree().change_scene_to_file("res://scenes/interim.tscn")
