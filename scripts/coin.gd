extends Area2D

func _ready() -> void:
	# Automatically connects the body_entered signal when the coin spawns
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.score += 1
		print("Score: ", GameManager.score)
		queue_free()
