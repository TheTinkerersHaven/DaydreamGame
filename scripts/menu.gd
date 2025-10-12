extends Control

func _on_play_pressed() -> void:
	if(Globals.sfx): Music.menusfx.play()
	get_tree().change_scene_to_file("res://Livello1.tscn")

func _on_settings_pressed() -> void:
	if(Globals.sfx): Music.menusfx.play()
	get_tree().change_scene_to_file("res://settings.tscn")
