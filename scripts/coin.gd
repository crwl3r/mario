extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.score += 1
		print("Score: ", GameManager.score)
		queue_free()
