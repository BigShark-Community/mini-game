extends Node2D


func _process(delta: float) -> void:
	# Quit game from level
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene_to_file("res://scenes/start.tscn")
	# Restart level
	elif (Input.is_action_just_pressed("ui_home")):
		get_tree().reload_current_scene()
