extends CharacterBody2D

@onready var jump_sfx = $"../Jump_SFX"
@onready var player_sprite = $AnimatedSprite2D
@onready var fade_rect = $"../CanvasLayer/FadeLayer/FadeRect"

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const MAX_SAFE_LANDING_SPEED = 900.0

var start_position: Vector2
var previous_velocity_y := 0.0
var was_on_floor := false

func _ready() -> void:
	fade_rect.modulate.a = 1.0  # inizia scuro
	var tween := create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.0)  # fade-in lento
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Applica gravità
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.stop()
	else:
		player_sprite.play()

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# Movimento orizzontale
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player_sprite.animation = "Run"
		velocity.x = direction * SPEED
		player_sprite.flip_h = direction < 0
	else:
		player_sprite.animation = "Idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Rileva caduta
	if not was_on_floor and is_on_floor():
		if previous_velocity_y > MAX_SAFE_LANDING_SPEED:
			_emit_death_and_respawn()

	was_on_floor = is_on_floor()
	previous_velocity_y = velocity.y  # salva la velocità prima del reset

	move_and_slide()

signal died

func _emit_death_and_respawn():
	emit_signal("died")
	await respawn()

func respawn() -> void:
	# Fade-out
	var fade_out_tween := create_tween()
	fade_out_tween.tween_property(fade_rect, "modulate:a", 1.0, 0.3)
	await fade_out_tween.finished
	await get_tree().create_timer(0.3).timeout

	# Respawn
	global_position = start_position
	velocity = Vector2.ZERO

	# Fade-in
	var fade_in_tween := create_tween()
	fade_in_tween.tween_property(fade_rect, "modulate:a", 0.0, 0.3)
	await fade_in_tween.finished
