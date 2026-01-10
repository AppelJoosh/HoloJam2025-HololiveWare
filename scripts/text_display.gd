extends Control
var time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var microgame = get_parent()
	if microgame != null:
		$Text.text = microgame.blurb


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if time > 1.0:
		global_position = lerp(global_position, Vector2(0,-1000), delta)
