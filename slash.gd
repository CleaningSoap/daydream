extends Area2D
var distance_travelled = 0
var damage = 10
func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 5000
	var direction = Vector2.RIGHT.rotated(-300)
	position += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	if distance_travelled > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("get_hit"):
		body.get_hit(damage)
