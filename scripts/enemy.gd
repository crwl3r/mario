extends CharacterBody2D

@export var speed: float = 50.0

var direction: float = -1.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dead: bool = false  

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $SideHitbox/Timer

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity.x = 0
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * speed
	move_and_slide()

	if is_on_wall():
		direction *= -1.0
		animated_sprite.flip_h = (direction > 0)
		position.x += direction * 2.0

func _on_side_hitbox_body_entered(body: Node2D) -> void:
	if is_dead: 
		return  
		
	if body.has_method("play_fall_off"):
		var knockback_dir: float = sign(body.global_position.x - global_position.x)
		if knockback_dir == 0:
			knockback_dir = 1.0
		body.play_fall_off(knockback_dir)
		
		print("You Died!")
		timer.start()
func _on_stomp_area_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if body.has_method("play_fall_off"):
		if body.velocity.y >= 0 or body.global_position.y < global_position.y:
			is_dead = true
			
			animated_sprite.play("ded")
				
			$CollisionShape2D.set_deferred("disabled", true)
			$SideHitbox/CollisionShape2D.set_deferred("disabled", true)
			$StompArea/CollisionShape2D.set_deferred("disabled", true)
			
			body.velocity.y = -250.0
			
			await get_tree().create_timer(50.0).timeout
			queue_free()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
