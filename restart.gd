extends Node2D

func _on_Retry_pressed():
	# replace path with your main scene path
	get_tree().change_scene_to_file("res://main.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_pressed() -> void:
	pass # Replace with function body.
