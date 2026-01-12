extends Area2D

signal catch

var catch_attempt: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space") and !catch_attempt:
		$Sprite2D.set_frame(0)
		catch_attempt = true
		catch.emit()
