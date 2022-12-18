extends Node2D

export var mainGameScene: PackedScene



func _on_NewGame_button_up():
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Credits_button_up():
	pass # Replace with function body.


func _on_Quit_button_up():
	get_tree().quit()



