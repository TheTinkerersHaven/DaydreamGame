extends Control

@onready var score_label = $CanvasLayer/MarginContainer/VBoxContainer/Score

func _ready() -> void:
	Music.songPlayer()
	score_label.text = "Your final score: %d" % Globals.score
