extends "res://scripts/MicrogameBase.gd"

@onready var win_block: Control = $CanvasLayer/WinBlock
@onready var fail_block: Control = $CanvasLayer/FailBlock

func _init() -> void:
	microgame_id = 1

func _ready() -> void:
	pass

func _on_win_block_mouse_entered() -> void:
	if (!is_active):
		return
		
	win_block.color = Color.WEB_GREEN
	is_active = false
	emit_signal("on_finish", true)
	timer.is_active = false

func _on_fail_block_mouse_entered() -> void:
	if (!is_active):
		return
		
	fail_block.color = Color.DARK_RED
	is_active = false
	emit_signal("on_finish", false)
	timer.is_active = false
