extends Sprite2D

class_name MG04_Ticket

@export var lifetime : float = 5.0
@onready var timer : Timer = $Timer
var velocity : Vector2 = Vector2()

func _physics_process(_delta: float) -> void:
	position += velocity

func on_target_hit(body: Node2D):
	if (body is MG04_Target):
		if (!body.has_hit):
			body.receive_ticket()
			queue_free()
