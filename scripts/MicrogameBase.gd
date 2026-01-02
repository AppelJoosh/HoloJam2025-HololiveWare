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

##When the microgame ends, give
var exit_timer = Timer.new()

@onready var timer: MicrogameTimer = $CanvasLayer/Control/MicrogameTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_timer.wait_time = 0.5
	#exit_timer.connect("timeout", exit_on_timeout)
	#exit_timer.connect(exit_timer.timeout, exit_on_timeout)
	exit_timer.timeout.connect(exit_on_timeout)
	add_child(exit_timer)
	
	on_finish.connect(start_despawning_after_end)
	
	pass # Replace with function body.


func start_despawning_after_end(_success: bool): # extra func parameter to make this compatible with the Microgame.on_finish(has_won: bool) signal
	exit_timer.start(0.5)

func exit_on_timeout():
	#queue_free()
	var parent_subviewport_container : SubViewportContainer = get_parent().get_parent()
	parent_subviewport_container.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	pass
