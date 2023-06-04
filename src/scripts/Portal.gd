extends Area2D


@export var NEXT_LEVEL: String = "" # (String, FILE)


func _on_Portal_body_entered(body: Node) -> void:
	if (body.name == "Player") || (body.name == "Godette"):
		if (NEXT_LEVEL != ""):
			get_tree().change_scene_to_file(NEXT_LEVEL)
		else:
			get_tree().change_scene_to_file("res://scenes/start.tscn")
