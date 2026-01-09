extends "res://scripts/MicrogameBase.gd"

var possible_steps = ["↑", "↓࢑", "←", "→"]
var input_dict = {Key.KEY_UP: "↑", Key.KEY_DOWN: "↓࢑", Key.KEY_LEFT: "←", Key.KEY_RIGHT: "→"}

@onready var player : Sprite2D = $Player

@onready var step_base : Label = $Step0
@onready var dance_sequence : HBoxContainer = $CanvasLayer/DanceSequence

func _ready() -> void:
	super()
	for i in range(10 + floor(speed_factor)):
		var next_step = step_base.duplicate()
		next_step.text = possible_steps[randi_range(0, len(possible_steps) - 1)]
		next_step.name = "Step%s" % i
		next_step.show()
		dance_sequence.add_child(next_step)
		if i == 0:
			next_step.self_modulate = Color.AQUA

func _input(_event: InputEvent) -> void:
	if !is_active:
		return
	
	if _event is InputEventKey and _event.is_pressed():
		match _event.physical_keycode:
			Key.KEY_UP, Key.KEY_DOWN, Key.KEY_LEFT, Key.KEY_RIGHT:
				var current_step : Label = dance_sequence.get_child(0)
				var next_step : Label = dance_sequence.get_child(1)
				if current_step.text == input_dict[_event.physical_keycode]: #correct
					dance_sequence.remove_child(current_step)
					current_step.queue_free()
					
					if len(dance_sequence.get_children()) == 0:
						on_finish.emit(true)
					else:
						next_step.self_modulate = Color.AQUA
				else: #incorrect
					current_step.self_modulate = Color.FIREBRICK
					on_finish.emit(false)
					player.rotation_degrees = 90
