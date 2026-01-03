class_name Microgame

extends Node

##emit this signal when a microgame concludes
signal on_finish(has_won: bool) 

#var microgame_id: int = -1;

var win_state: bool = false
var time: int = 10;
##the absolute minimum time allowed for this microgame
var min_time: int = 5; 
var speed_factor: float = 1.0
var blurb: String = "Objective!";
##use to prevent interactions that can cause glitches (i.e. failing after reaching win state)
var is_active: bool = true 

##When the microgame ends, give some time in between the end and despawning it to smoothen the game's pace
var exit_timer = Timer.new()

@onready var timer: MicrogameTimer = $CanvasLayer/Control/MicrogameTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func lose_on_time_up():
	on_finish.emit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	pass
