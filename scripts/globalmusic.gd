extends Node

@onready var musicplayer = $musicplayer
@onready var menusfx = $menusfx
var canzone

func _ready():
	songPlayer()

func songPlayer():
	var name = get_tree().current_scene.name
	if Globals.music:
		if name == "Menu" || name == "Settings":
			canzone = load("res://sounds/menumusic.mp3")
		elif name == "Livello1":
			canzone = load("res://sounds/level1.mp3")
		elif name == "Livello2":
			canzone = load("res://sounds/level2.mp3")
		
		if canzone:
			musicplayer.stream = canzone
			musicplayer.play()

func _on_music_finished() -> void:
	musicplayer.play()
