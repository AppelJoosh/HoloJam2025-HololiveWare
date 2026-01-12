extends "res://scripts/MicrogameBase.gd"

var possible_steps = [Key.KEY_UP, Key.KEY_DOWN, Key.KEY_LEFT, Key.KEY_RIGHT]
#var input_dict = {Key.KEY_UP: "↑", Key.KEY_DOWN: "↓", Key.KEY_LEFT: "←", Key.KEY_RIGHT: "→"}
var input_dict = {Key.KEY_UP: 0, Key.KEY_RIGHT: 90, Key.KEY_DOWN: 180, Key.KEY_LEFT: 270}

@onready var player : Sprite2D = $Player

@onready var step_base : Control = $Step_
@onready var dance_sequence : HBoxContainer = $CanvasLayer/DanceSequence

func _ready() -> void:
	super()
	for i in range(10 + floor(speed_factor * 2)):
		var next_step : Control = step_base.duplicate()
		#next_step.text = possible_steps[randi_range(0, len(possible_steps) - 1)]
		#print(input_dict.values())
		var arrow : Sprite2D = next_step.get_child(0)
		arrow.rotation_degrees = input_dict.values()[randi_range(0, len(possible_steps) - 1)]
		next_step.name = "Step%s" % i
		next_step.show()
		dance_sequence.add_child(next_step)
		
		if i == 0:
			next_step.modulate = Color.AQUA

func _input(_event: InputEvent) -> void:
	if !is_active:
		return
	
	if _event is InputEventKey and _event.is_pressed():
		match _event.physical_keycode:
			Key.KEY_UP, Key.KEY_DOWN, Key.KEY_LEFT, Key.KEY_RIGHT:
				var current_step : Control = dance_sequence.get_child(0)
				var arrow : Sprite2D = current_step.get_child(0)
				var next_step : Control = dance_sequence.get_child(1)
				if arrow.rotation_degrees == input_dict[_event.physical_keycode]: #correct
					dance_sequence.remove_child(current_step)
					current_step.queue_free()
					
					if len(dance_sequence.get_children()) == 0:
						on_finish.emit(true)
					else:
						next_step.modulate = Color.AQUA
				else: #incorrect
					current_step.modulate = Color.FIREBRICK
					on_finish.emit(false)
					player.rotation_degrees = 90
