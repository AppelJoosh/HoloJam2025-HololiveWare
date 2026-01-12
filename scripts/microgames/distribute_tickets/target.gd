extends CharacterBody2D

class_name MG04_Target

@export var speed : float = 16.0
var movement_velocity = Vector2(1,0);
var has_hit = false

signal ticket_received()

func _ready() -> void:
	speed = randf_range(0.5, 2.0)

func _physics_process(_delta: float) -> void:
	if (has_hit):
		return
	
	var collision = move_and_collide(movement_velocity * speed)
	
	if (collision != null && is_instance_valid(collision.get_collider())):
		speed *= -1 # turn around when hitting the wall
		
func receive_ticket():
	has_hit = true
	ticket_received.emit()
