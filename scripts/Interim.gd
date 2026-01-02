extends TextureRect

var score : int = 0
var lives : int = 4

##This timer spawns a second microgame to accompany the first one
var timer : Timer

##The current active microgames
var microgame: Array[Microgame] = [];

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func add_new_microgame(microgameId: int):
	pass
	
