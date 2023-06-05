extends Area2D

func _on_spikes_body_entered(body: Node2D) -> void:
	print(body.name)
	if (body.name == "Player") || (body.name == "Godette"):
		Globals.lives -= 1
		Globals.live_lost.emit()

