extends CanvasLayer


func _ready():
	if Input.is_action_just_pressed("open_hp_sacrifice"):
		print("yes")
		get_tree().paused = true
		%Canvas_layer.set_visible = true
