extends RigidBody2D

signal win_flag

var held: bool = true
var grabbable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_catch_drop_hand_release() -> void:
	set_freeze_enabled(false)


func _on_catch_player_hand_catch() -> void:
	if grabbable:
		set_freeze_enabled(true)
		win_flag.emit()


func _on_catch_player_hand_body_entered(_body: Node2D) -> void:
	grabbable = true


func _on_catch_player_hand_body_exited(_body: Node2D) -> void:
	grabbable = false
