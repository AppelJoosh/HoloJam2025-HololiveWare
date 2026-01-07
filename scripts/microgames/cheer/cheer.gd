extends Microgame

var left_done: bool = false
var right_done: bool = false
var complete: bool = false		# prevent repeated fanfare?
var confetti: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if left_done and right_done and !complete:
		win_state = true
		print("game complete")
		# figure out fanfare
		confetti += $Confetti.get_children()
		confetti += $Confetti2.get_children()
		for child in confetti:
			child.set_emitting(true)
		complete = true


func _on_cheer_arm_right_finished() -> void:
	right_done = true
	print("right arm done")


func _on_cheer_arm_left_finished() -> void:
	left_done = true
	print("left arm done")
