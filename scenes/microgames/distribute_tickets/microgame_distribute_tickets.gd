extends "res://scripts/MicrogameBase.gd"

var targets_hit = 0;
@export var targets_required = 2;

var shoot_direction = Vector2(0, -15)

@onready var player : CharacterBody2D = $Player
var player_movement = Vector2()

# use these references for cloning
@onready var ticket_base = $Ticket
@onready var target_base = $Target

func _init():
	targets_required = 2 + floor(speed_factor / 10)

func _ready() -> void:
	super()
	
	for i in range(targets_required):
		var new_target : MG04_Target = target_base.duplicate();
		new_target.ticket_received.connect(on_target_ticket_received)
		new_target.position = Vector2(randi_range(420, 750), 185 + i * 75)
		new_target.show()
		add_child(new_target)
	
func _physics_process(_delta: float) -> void:
	#player.position += player_movement
	player.move_and_collide(player_movement)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			Key.KEY_LEFT:
				player_movement.x = -6 if event.pressed else 0
			Key.KEY_RIGHT:
				player_movement.x =  6 if event.pressed else 0
			Key.KEY_UP:
				if event.pressed and not event.echo:
					shoot_ticket()
	
func shoot_ticket():
	var new_ticket : MG04_Ticket = ticket_base.duplicate()
	add_child(new_ticket)
	new_ticket.position = player.position
	new_ticket.show()
	new_ticket.velocity = shoot_direction
	new_ticket.timer.start(5.0)

func on_target_ticket_received():
	targets_hit += 1
	
	if (targets_hit >= targets_required):
		on_finish.emit(true)
