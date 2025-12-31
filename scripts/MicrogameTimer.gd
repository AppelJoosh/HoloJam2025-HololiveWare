extends Node2D
@onready var timer_bar: Polygon2D = $TimerBar
@onready var timer_value: Label = $TimeValue

@export var max_time: float = 10.0
@export var time: float = 10.0

@export var width: float = 720

signal on_timeout()

func _physics_process(delta: float) -> void:
	if time > 0:
		time -= delta
		timer_bar.scale.x = time / max_time * width
		timer_value.text = ("%3.2f" % time)
	else:
		time = 0
		timer_value.hide()
		emit_signal("on_timeout")
