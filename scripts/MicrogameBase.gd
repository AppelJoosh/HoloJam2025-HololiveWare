class_name Microgame

extends Node

@export_flags("WASD", "Arrow Keys", "Mouse", "Spacebar") var control_type: int = 0
#@export_category()
enum CONTROL_TYPE {
	WASD = 1 << 0,
	ARROW_KEYS = 1 << 1,
	MOUSE = 1 << 2,
	SPACEBAR = 1 << 3
}

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
	timer.on_timeout.connect(on_finish.emit.bind(false));
	on_finish.connect(deactivate_on_end)
	
func lose_on_time_up():
	on_finish.emit(false)

func deactivate_on_end(_win_state: bool):
	timer.is_active = false
	is_active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	pass
