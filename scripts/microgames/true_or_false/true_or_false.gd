extends "res://scripts/MicrogameBase.gd"

@onready var question_label : Label = $CanvasLayer/Question

@onready var true_block : Button = $CanvasLayer/VBoxContainer/TrueBlock
@onready var false_block : Button = $CanvasLayer/VBoxContainer/FalseBlock

var question_index = -1
var correct_answer : bool

var tf_questions = [
	["Hololive 2nd Fes. was held at Makuhari Messe Event Hall.", false],
	["The first Hololive Super Expo was hosted alongside Hololive 3rd Fes.", true],
	["Bushiroad was the biggest sponsor behind Hololive 6th Fes.", false],
	["Unlike the other HoloFes events, the first was held for one day.", true],
	["Hololive 4th Fes. introduced the new 3-screen setup for the venue.", false],
	["'Hololive English 1st Concert -Connect the World-' featured 3 guest talents each from the other Hololive branches.", true],
	["Hololive 6th Fes. was streamed on the Niconico, SPWN, and eplus platforms.", false],
	["2020 is the only year to feature two separate HoloFes events.", true],
	["Hololive 5th Fes. showcased the holo*27 collaboration project.", false],
	["Hololive 2nd Fes. was the first HoloFes event to be held on multiple days.", true],
]

func _ready() -> void:
	super()
	question_index = randi_range(0, len(tf_questions) - 1)
	question_label.text = tf_questions[question_index][0]
	correct_answer = tf_questions[question_index][1]
	
func _on_finish(_state: bool):
	true_block.disabled = true
	false_block.disabled = true
	
func on_answer(answer: bool):
	print(answer)
	if (correct_answer):
		true_block.self_modulate = Color.WEB_GREEN
		false_block.self_modulate = Color.FIREBRICK
	else:
		true_block.self_modulate = Color.FIREBRICK
		false_block.self_modulate = Color.WEB_GREEN
		
	on_finish.emit(correct_answer == answer)
