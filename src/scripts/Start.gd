extends Node2D

export var mainGameScene: PackedScene



func _on_NewGame_button_up() -> void:
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Credits_button_up() -> void:
	pass # Replace with function body.


func _on_Quit_button_up() -> void:
	get_tree().quit()

