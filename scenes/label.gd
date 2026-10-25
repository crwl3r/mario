extends Label

func _process(delta: float) -> void:
	text = "Coins: " + str(GameManager.score)
