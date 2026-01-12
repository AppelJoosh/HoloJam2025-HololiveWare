extends Node2D

var left_area_touched: bool = false
var right_area_touched: bool = false
var complete: bool = false		# prevent repeated emits

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if left_area_touched and right_area_touched and !complete:
		finished.emit()
		complete = true


func _on_swing_left_body_entered(body: Node2D) -> void:
	if body.name == "arm_right":
		left_area_touched = true


func _on_swing_right_body_entered(body: Node2D) -> void:
	if body.name == "arm_right":
		right_area_touched = true
