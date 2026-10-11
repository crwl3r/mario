extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var is_hurt: bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_hurt:
		move_and_slide()
		return

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func play_fall_off(knockback_direction: float) -> void:
	is_hurt = true
	velocity.y = -200.0
	velocity.x = knockback_direction * 120.0
	
	$CollisionShape2D.set_deferred("disabled", true)
