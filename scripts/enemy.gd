extends CharacterBody2D

@export var speed: float = 50.0

var direction: float = -1.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * speed
	move_and_slide()

	if is_on_wall():
		direction *= -1.0
		animated_sprite.flip_h = (direction > 0)