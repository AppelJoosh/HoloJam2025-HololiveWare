extends Area2D

signal release

func _ready() -> void:
	$Timer.start(randi_range(1, 3))


# after microgame start and random time has passed, unfreeze glowstick
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Sprite2D.set_frame(1)
	release.emit()
