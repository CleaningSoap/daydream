extends Area2D
var distance_travelled = 0
var damage = 5
var direction = 1
const SPEED = 500
const RANGE = 5000
@onready var timeout: Timer = $Timeout
var damage_multiplier = 1
const PLAYERPATH = "/root/Main/Player"
var player
@onready var sprite: Sprite2D = $Sprite2D
var last_dir = 0

func _ready():
	player = get_node(PLAYERPATH)
	
func _physics_process(delta: float) -> void:
	var dir = player.dir
	if dir != 0:  # Only update last_dir when the player moves
		last_dir = dir  
	if last_dir == -1:  # Facing left
		sprite.rotation += 180
	elif last_dir == 1:  # Facing right
		sprite.rotation -= 180
	position.x += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_hit"):
		body.get_hit(damage * damage_multiplier)
		queue_free()


func _on_timeout_timeout() -> void:
	queue_free()
