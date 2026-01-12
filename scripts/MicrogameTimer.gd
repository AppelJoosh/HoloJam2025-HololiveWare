class_name MicrogameTimer

extends Node2D
##The white portion of the timer that drains
@onready var timer_bar: Polygon2D = $TimerBar 
##The value of the time remaining in seconds
@onready var timer_value: Label = $TimeValue 

@export var max_time: float = 10.0
var time: float = 10.0

@export var is_active: bool = true

@export var width: float = 720

signal on_timeout()

func _ready() -> void:
	time = max_time

func _physics_process(delta: float) -> void:
	if (!is_active):
		return
	
	if time > 0:
		time -= delta
		timer_bar.scale.x = time / max_time * width
		timer_value.text = ("%3.2f" % time)
	else:
		time = 0
		timer_value.text = "0.00"
		timer_value.hide()
		emit_signal("on_timeout")
