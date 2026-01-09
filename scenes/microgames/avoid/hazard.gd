extends CharacterBody2D

class_name MG05_Hazard

var movement = Vector2()
var speed = 2.4

func _ready() -> void:
	#movement = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	#movement = Vector2.from_angle(randf_range(0, 2 * PI))
	speed = randf_range(0.6, 2.0)
	#position = Vector2(randf_range(375, 800), randf_range(175, 490))
	var distance = randi_range(105, 180)
	var angle = randf_range(0, 2 * PI)
	
	var displacement = Vector2.from_angle(angle) * distance
	position = Vector2(600, 345) + displacement
	
	# initially move away from the player
	movement = (displacement + Vector2.from_angle(randf_range(-PI, PI))).normalized()
	
func _physics_process(_delta: float) -> void:
	var collision = move_and_collide(movement * speed)
	
	if collision != null:
		#movement *= -collision.get_normal()
		var normal = collision.get_normal()
		#print(movement, normal)
		movement += normal * normal.dot(-movement)*2
		movement = movement.normalized()
		move_and_collide(normal)
