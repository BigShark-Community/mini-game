extends Node2D

# Szene des ersten Level, der geladen wird, wenn man auf New Game klickt
export var mainGameScene: PackedScene

# Starten des Spiels in angegebenem Level
func _on_NewGame_button_up() -> void:
	get_tree().change_scene(mainGameScene.resource_path)

# Credits/Optionen werden aktuell nicht bearbeitet
func _on_Credits_button_up() -> void:
	pass # Replace with function body.

# Schließen des Spiels
func _on_Quit_button_up() -> void:
	get_tree().quit()
