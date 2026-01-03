extends TextureRect

var score : int = 0
var lives : int = 4

@onready var score_display : Label = $ScoreCount

@onready var microgame_container : GridContainer = $CenterContainer/GridContainer

var microgame_filepaths: Array[String] = [
	"res://scenes/microgames/test_microgame_3.tscn",
	"res://scenes/microgames/test_microgame_2.tscn"
]

##This timer spawns a second microgame to accompany the first one
var timer : Timer

##The current active microgames
var microgame: Array[Microgame] = [];

func _ready() -> void:
	add_new_microgame(0)
	pass

func _physics_process(_delta: float) -> void:
	pass
	
##Loads the next microgame dynamically, and connects it to the necessary functions
func add_new_microgame(microgameId: int) -> Microgame:
	var microgame_resource: Resource = load(microgame_filepaths[microgameId])
	var new_microgame: Microgame = microgame_resource.instantiate()
	
	var subviewport = SubViewport.new()
	
	var subviewport_container = SubViewportContainer.new()
	subviewport_container.stretch = true
	subviewport_container.custom_minimum_size = Vector2(512, 384)
	
	subviewport.add_child(new_microgame)
	subviewport_container.add_child(subviewport)
	
	microgame_container.add_child(subviewport_container)
	
	new_microgame.on_finish.connect(on_microgame_finish.bind(subviewport_container), ConnectFlags.CONNECT_ONE_SHOT)
	
	return new_microgame
	
func on_microgame_finish(success: bool, microgame_window: SubViewportContainer):
	if success:
		set_score(score + 1)
	else:
		lives -= 1

	# despawn the old completed microgame
	var old_microgame_despawn_timer = Timer.new()
	old_microgame_despawn_timer.timeout.connect(microgame_window.queue_free)
	old_microgame_despawn_timer.timeout.connect(old_microgame_despawn_timer.queue_free)
	add_child(old_microgame_despawn_timer)
	old_microgame_despawn_timer.start(0.5)
	
	# spawn the next microgame after some time, and free that timer to prevent memory leaks
	var new_microgame_spawn_timer = Timer.new()
	new_microgame_spawn_timer.timeout.connect(add_new_microgame.bind(randi_range(0, len(microgame_filepaths) - 1)))
	new_microgame_spawn_timer.timeout.connect(new_microgame_spawn_timer.queue_free)
	add_child(new_microgame_spawn_timer)
	new_microgame_spawn_timer.start(1.0)
		
func set_score(value: int):
	score = value;
	score_display.text = str(score)
