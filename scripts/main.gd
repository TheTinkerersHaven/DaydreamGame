extends Node

var player: CharacterBody2D
var max_height := 0
var previous_score := 0

func _ready():
	var area = $Area2D
	area.body_entered.connect(_on_body_entered)
	
	player = get_node("CharacterBody2D")
	if not player:
		print("Player not found")
	else:
		player.connect("died", Callable(self, "_on_player_died"))
	
	previous_score = Globals.score;
	
	Music.songPlayer()

func _process(delta):
	var current_height := -player.global_position.y  # Higher up = more negative Y

	if current_height > max_height:
		max_height = current_height
		Globals.score = previous_score + (max_height / 10)  # 1 point every 10 pixels
		update_score_display()

func _on_player_died() -> void:
	print("Player died — score update triggered")
	if Globals.score < 100:
		Globals.score = 0
		max_height = 0
	else:
		Globals.score -= 100
	update_score_display()

		
func update_score_display():
	var score_label := get_node("CanvasLayer/FadeLayer/Label")
	if score_label:
		score_label.text = "Score: %d" % Globals.score
	else:
		print("Label not found!")
		
func _on_body_entered(body):
	if body.is_in_group("player"):
		var current_scene := get_tree().current_scene
		if current_scene and current_scene.scene_file_path != "res://livello2.tscn":
			get_tree().change_scene_to_file("res://livello2.tscn")
