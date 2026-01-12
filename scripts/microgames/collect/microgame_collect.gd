extends "res://scripts/MicrogameBase.gd"

@onready var player : CharacterBody2D = $Player
@export var player_speed = 4.0;
var player_movement = Vector2()

var merch_count = 0
var merch_collected = 0

@onready var merch_base : Area2D = $Merch

func _ready() -> void:
	super()
	win_on_timeout = false
	merch_count = 2 + floor(speed_factor * 0.5)
	for i in range(merch_count):
		var new_merch : Area2D = merch_base.duplicate()
		new_merch.position = Vector2(randf_range(375, 800), randf_range(175, 490))
		new_merch.name = "Merch_%s" % i
		add_child(new_merch)

func _physics_process(_delta: float) -> void:
	player.move_and_collide(player_movement * player_speed)

func _input(_event: InputEvent) -> void:
	player_movement = Input.get_vector("LeftArrow", "RightArrow", "UpArrow", "DownArrow")

# connect merch node to this method
func merch_collect(area: Area2D):
	if area.name.contains("Merch") and is_active:
		area.queue_free()
		merch_collected += 1
		if merch_collected >= merch_count:
			on_finish.emit(true)
