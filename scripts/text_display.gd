extends Control
var time: float = 0
var microgame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	microgame = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if microgame != Microgame:
		$Text.text = microgame.blurb
	time += delta
	if time > 1.0:
		global_position = lerp(global_position, Vector2(0,-1000), delta)
