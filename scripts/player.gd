extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Flag to lock normal movement when hit
var is_hurt: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# If the player is hurt, skip normal input and let physics handle the fall-off
	if is_hurt:
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# This function is called by the enemy when touched from the side
func play_fall_off(knockback_direction: float) -> void:
	is_hurt = true
	# Pop the player up and push them away from the enemy
	velocity.y = -200.0
	velocity.x = knockback_direction * 120.0
	
	# Disable the player's main collider so they fall straight through platforms
	$CollisionShape2D.set_deferred("disabled", true)
