extends Area2D

signal live_lost

func _on_spikes_body_entered(body: Node2D) -> void:
	print(body.name)
	if (body.name == "Player") || (body.name == "Godette"):
		Globals.lives -= 1
		emit_signal("live_lost")

