extends Area2D
var distance_travelled = 0
var damage = 10
var direction = 1
const SPEED = 500
const RANGE = 5000

func _physics_process(delta: float) -> void:
	
	position.x += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_hit"):
		body.get_hit(damage)
		queue_free()
