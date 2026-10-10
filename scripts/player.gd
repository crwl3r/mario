extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Flag to disable normal movement when hit by an enemy
var is_hurt: bool = false

func _physics_process(delta: float) -> void:
	# Add gravity continuously
	if not is_on_floor():
		velocity += get_gravity() * delta

	# If hurt, don't allow user input—just let physics/knockback take over
	if is_hurt:
		move_and_slide()
		return

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Function called when hit from the side
func play_fall_off(knockback_direction: float) -> void:
	is_hurt = true
	# Pop player slightly up and push them away from enemy
	velocity.y = -150.0 
	velocity.x = knockback_direction * 100.0
	
	# Disable collisions with floor/enemies so player falls straight through platforms
	$CollisionShape2D.set_deferred("disabled", true)
