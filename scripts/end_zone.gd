extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Level Finished!")
		
		var victory_label = get_tree().get_first_node_in_group("victory_ui")
		if victory_label:
			victory_label.visible = true
			
		await get_tree().create_timer(3.0).timeout
		
		GameManager.score = 0
		get_tree().reload_current_scene()
