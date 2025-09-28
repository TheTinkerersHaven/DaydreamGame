extends Node

var player: CharacterBody2D
var max_height := 0
var score := 0

func _ready():
	player = get_node("CharacterBody2D")
	if not player:
		print("Player not found")
	else:
		player.disconnect("died", Callable(self, "_on_player_died"))  # Prevent duplicates
		player.connect("died", Callable(self, "_on_player_died"))

func _process(delta):
	var current_height := -player.global_position.y  # Higher up = more negative Y

	if current_height > max_height:
		max_height = current_height
		score = int(max_height / 10)  # 1 point every 10 pixels
		update_score_display()

func _on_player_died() -> void:
	print("Player died — score update triggered")
	if score < 100:
		score = 0
	else:
		score -= 100
	update_score_display()

		
func update_score_display():
	var score_label := get_node("CanvasLayer/FadeLayer/Label")
	if score_label:
		score_label.text = "Score: %d" % score
	else:
		print("Label not found!")
