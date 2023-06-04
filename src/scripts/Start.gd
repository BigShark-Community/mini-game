extends Node2D

@export var mainGameScene: PackedScene



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		do_quit()

func _on_NewGame_button_up() -> void:
	get_tree().change_scene_to_file(mainGameScene.resource_path)


func _on_Credits_button_up() -> void:
	pass # Replace with function body.


func _on_Quit_button_up() -> void:
	do_quit()


## PRIVATE METHODS

func do_quit() -> void:
	get_tree().quit()
