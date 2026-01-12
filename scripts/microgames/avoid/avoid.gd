extends "res://scripts/MicrogameBase.gd"

@onready var player : CharacterBody2D = $Player
@export var player_speed = 4.0;
var player_movement = Vector2()

@onready var hazard_base : CharacterBody2D = $Hazard

func _ready() -> void:
	super()
	win_on_timeout = true
	var hazard_count = 2 + floor(speed_factor * 1.44)
	for i in range(hazard_count):
		var new_hazard : MG05_Hazard = hazard_base.duplicate()
		add_child(new_hazard)
		new_hazard.speed *= speed_factor

func _physics_process(_delta: float) -> void:
	player.move_and_collide(player_movement * player_speed * speed_factor)

func _input(_event: InputEvent) -> void:
	player_movement = Input.get_vector("A", "D", "W", "S")

func fail_on_hazard_hit(body: Node):
	if body is MG05_Hazard and is_active:
		player.hide()
		on_finish.emit(false)
