extends TextureRect

var score : int = 0
var lives : int = 4

const MAX_ACTIVE_MICROGAMES = 2

@onready var score_display : Label = $ScoreCount

@onready var microgame_container : GridContainer = $CenterContainer/GridContainer

var microgame_filepaths: Array[String] = [
	#"res://scenes/microgames/test_microgame_3.tscn",
	"res://scenes/microgames/catch_the_light/catch_the_light.tscn",
	"res://scenes/microgames/distribute_tickets/microgame_distribute_tickets.tscn",
	"res://scenes/microgames/true_or_false/true_or_false.tscn",
	"res://scenes/microgames/cheer/cheer.tscn",
	"res://scenes/microgames/collect/collect.tscn",
	"res://scenes/microgames/avoid/avoid.tscn",
	"res://scenes/microgames/dance_practice/dance_practice.tscn",
]

var microgame_control_types: Array[Microgame.CONTROL_TYPE] = [
	#Microgame.CONTROL_TYPE.MOUSE,
	Microgame.CONTROL_TYPE.SPACEBAR,
	Microgame.CONTROL_TYPE.ARROW_KEYS,
	Microgame.CONTROL_TYPE.MOUSE,
	Microgame.CONTROL_TYPE.ARROW_KEYS + Microgame.CONTROL_TYPE.WASD,
	Microgame.CONTROL_TYPE.ARROW_KEYS,
	Microgame.CONTROL_TYPE.WASD,
	Microgame.CONTROL_TYPE.ARROW_KEYS
]
## A bitfield variable to keep track of which control types are in use
var active_microgame_control_types = 0

##This timer spawns a second microgame to accompany the first one
@onready var timer : Timer = $SubMicrogameSpawnTimer

@onready var lives_container : HBoxContainer = $LivesContainer

##The current active microgames
var microgame: Array[Microgame] = [];

func _ready() -> void:
	#add_new_microgame(0)
	#add_random_new_microgame_on_timeout()
	timer.start(randf_range(4, 16))
	pass

func _physics_process(_delta: float) -> void:
	pass
	
##Get the next microgame, based on what is compatible with the current active ones
func get_next_microgame_index():
	var idx = -1
	for i in range(5):
		var _idx = randi_range(0, len(microgame_filepaths) - 1)
		var control_type = microgame_control_types[_idx]
		if (active_microgame_control_types & control_type == 0):
			idx = _idx
			break

	return idx

##Loads the next microgame dynamically, and connects it to the necessary functions
func add_new_microgame(microgameId: int) -> Microgame:
	if (len(microgame_container.get_children()) >= MAX_ACTIVE_MICROGAMES):
		return
		
	if (microgameId == -1):
		return
		
	#if lives <= 0:
		#print("ur ded")
		#var transition_player : AnimationPlayer = get_node("BlackFadeTransition/AnimationPlayer")
		#transition_player.play("GameOverTransition")
		#return
		
	var microgame_resource: Resource = load(microgame_filepaths[microgameId])
	var new_microgame: Microgame = microgame_resource.instantiate()
	var new_microgame_control_type = microgame_control_types[microgameId]
	new_microgame.speed_factor = 1.0 + score * 0.2 # gradually ramp up difficulty as score gets higher
	
	var subviewport = SubViewport.new()
	
	var subviewport_container = SubViewportContainer.new()
	subviewport_container.stretch = true
	subviewport_container.custom_minimum_size = Vector2(512, 384)
	
	subviewport.add_child(new_microgame)
	subviewport_container.add_child(subviewport)
	microgame_container.add_child(subviewport_container)
	
	# block other microgames of the same control type from entering until this one is done
	active_microgame_control_types |= new_microgame_control_type
	print(active_microgame_control_types)
	
	new_microgame.on_finish.connect(on_microgame_finish.bind(subviewport_container), ConnectFlags.CONNECT_ONE_SHOT)
	new_microgame.on_finish.connect(free_microgame_control_type_on_finish.bind(new_microgame_control_type), ConnectFlags.CONNECT_ONE_SHOT)
	
	return new_microgame
	
func add_random_new_microgame_on_timeout():
	if (len(microgame_container.get_children()) >= MAX_ACTIVE_MICROGAMES):
		print("too many microgamesss")
		return
	
	var idx = get_next_microgame_index()
	add_new_microgame(idx)
	
func restart_second_microgame_spawn_timer():
	timer.start(randf_range(4, 15))
	
func on_microgame_finish(success: bool, microgame_window: SubViewportContainer):
	if success:
		set_score(score + 1)
	else:
		lives -= 1
		#lives_container.remove_child(lives_container.get_child(0))
		var life_to_lose = lives_container.get_child(0)
		if (is_instance_valid(life_to_lose)): 
			life_to_lose.queue_free()
		
		if lives <= 0:
			print("ur ded")
			var transition_player : AnimationPlayer = get_node("BlackFadeTransition/AnimationPlayer")
			transition_player.play("GameOverTransition")
			GlobalVars.final_score = score
			return

	# despawn the old completed microgame
	var old_microgame_despawn_timer = Timer.new()
	old_microgame_despawn_timer.timeout.connect(microgame_window.queue_free)
	old_microgame_despawn_timer.timeout.connect(old_microgame_despawn_timer.queue_free)
	add_child(old_microgame_despawn_timer)
	old_microgame_despawn_timer.start(0.5)
	
	# spawn the next microgame after some time, and free that timer to prevent memory leaks
	if (len(microgame_container.get_children()) < MAX_ACTIVE_MICROGAMES):
		#var new_microgame_index = get_next_microgame_index()
		var new_microgame_spawn_timer = Timer.new()
		#new_microgame_spawn_timer.timeout.connect(add_new_microgame.bind(new_microgame_index))
		new_microgame_spawn_timer.timeout.connect(add_random_new_microgame_on_timeout)
		new_microgame_spawn_timer.timeout.connect(new_microgame_spawn_timer.queue_free)
		add_child(new_microgame_spawn_timer)
		new_microgame_spawn_timer.start(1.0)

func free_microgame_control_type_on_finish(_win_state: bool, control_type: int):
	active_microgame_control_types ^= control_type
	print(active_microgame_control_types)
	
func set_score(value: int):
	score = value;
	score_display.text = str(score)

func transition_to_end():
	get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
