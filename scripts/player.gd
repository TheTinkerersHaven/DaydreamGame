extends CharacterBody2D

@onready var jump_sfx = $"../Jump_SFX"
@onready var player_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.stop()
	else:
		player_sprite.play()
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player_sprite.animation = "Run"
		velocity.x = direction * SPEED
		player_sprite.flip_h = direction < 0
	else:
		player_sprite.animation = "Idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
