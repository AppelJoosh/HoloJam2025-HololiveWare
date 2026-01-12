extends CharacterBody2D


const SPEED = .05


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
	if direction:
		rotate(direction * SPEED)
		rotation_degrees = clamp(rotation_degrees, -90, 90)

	move_and_slide()
