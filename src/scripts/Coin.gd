extends Area2D

signal coin_collected

func _on_Coin_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		Globals.coins += 1
		emit_signal("coin_collected")
		queue_free()
