extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed('ui_left'):
		animated_sprite_2d.flip_h = true
	if Input.is_action_just_pressed('ui_right'):
		animated_sprite_2d.flip_h = false

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.animation = "run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.animation = "idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"

	move_and_slide()
