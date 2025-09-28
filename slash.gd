extends Area2D
var distance_travelled = 0

func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	if distance_travelled > RANGE:
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
