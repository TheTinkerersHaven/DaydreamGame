extends Node

@onready var musicplayer = $musicplayer
@onready var menusfx = $menusfx
var canzone

func _ready():
	songPlayer()

func songPlayer():
	var scenename = get_tree().current_scene.name
	if Globals.music:
		if scenename == "End":
			canzone = load("res://sounds/endmusic.ogg")
		elif scenename == "Menu" or scenename == "Settings":
			canzone = load("res://sounds/menumusic.ogg")
		elif scenename == "Livello1":
			canzone = load("res://sounds/level1.ogg")
		elif scenename == "Livello2":
			canzone = load("res://sounds/level2.ogg")
		elif scenename == "Livello3":
			canzone = load("res://sounds/level3.ogg")
		
		if canzone:
			canzone.loop = true
			musicplayer.stream = canzone
			musicplayer.play()
