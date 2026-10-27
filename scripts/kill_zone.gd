extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("You Died!")
		
		GameManager.score = 0
		
		var game_over_label = get_tree().get_first_node_in_group("game_over_ui")
		if game_over_label:
			game_over_label.visible = true
		
		timer.start() 

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
