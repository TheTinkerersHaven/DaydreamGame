extends Control

@onready var musicbutton = $CanvasLayer/MarginContainer/VBoxContainer/Music
@onready var sfxbutton = $CanvasLayer/MarginContainer/VBoxContainer/SFX

func _ready() -> void:
	musicbutton.button_pressed = Globals.music
	sfxbutton.button_pressed = Globals.sfx

func _on_music_toggled(toggled_on: bool) -> void:
	Globals.music = toggled_on
	if Globals.sfx: Music.menusfx.play()
	if !toggled_on && Music.musicplayer.playing: Music.musicplayer.stop()
	elif toggled_on && !Music.musicplayer.playing: Music.songPlayer()

func _on_sfx_toggled(toggled_on: bool) -> void:
	Globals.sfx = toggled_on
	if Globals.sfx: Music.menusfx.play()

func _on_back_pressed() -> void:
	if Globals.sfx: Music.menusfx.play()
	get_tree().change_scene_to_file("res://menu.tscn")
