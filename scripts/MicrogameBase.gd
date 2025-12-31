extends Node

signal on_finish(has_won: bool) #emit this signal when a microgame concludes

var win_state: bool = false
var time: int = 10;
var min_time: int = 5; #the absolute minimum time allowed for this microgame
var speed_factor: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	pass
