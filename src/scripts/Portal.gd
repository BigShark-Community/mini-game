extends Area2D


export(String, FILE) var NEXT_LEVEL: String = ""


func _on_Portal_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		if (NEXT_LEVEL != ""):
			get_tree().change_scene(NEXT_LEVEL)
		else:
			get_tree().change_scene("res://scenes/start.tscn")
