#extends "res://scripts/MicrogameBase.gd"
extends Microgame

@onready var win_block: Control = $CanvasLayer/WinBlock
@onready var fail_block: Control = $CanvasLayer/FailBlock

func _ready() -> void:
	super()
	pass

func _on_win_block_mouse_entered() -> void:
	if (!is_active):
		return
		
	win_block.color = Color.WEB_GREEN
	is_active = false
	on_finish.emit(true)
	timer.is_active = false

func _on_fail_block_mouse_entered() -> void:
	if (!is_active):
		return
		
	fail_block.color = Color.DARK_RED
	is_active = false
	on_finish.emit(false)
	timer.is_active = false
