extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_catch_glowstick_win_flag() -> void:
	win_state = true
