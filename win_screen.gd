extends Node2D
@onready var win_screen: Node2D = $"."


func _on_button_pressed() -> void:
	win_screen.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()
