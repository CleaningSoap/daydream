extends CharacterBody2D

var player
var weapon

const PLAYERPATH = "/root/Main/Player"
const WEAPONPATH = "/root/Main/Player/Sword"
const SPEED = 100
var enemy_type = "bomber" #can also be bomber or shooter
const FOLLOW_DISTANCE = 50
const EXPLODE_DISTANCE = 50

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(PLAYERPATH)
	weapon = get_node(WEAPONPATH)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if enemy_type == "chaser":
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		move_and_slide()
	elif enemy_type == "bomber":
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		move_and_slide()
		if global_position.distance_to(player.global_position) < EXPLODE_DISTANCE:
			bomb()
	elif enemy_type == "shooter":
		if global_position.distance_to(player.global_position) > FOLLOW_DISTANCE:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * SPEED
			move_and_slide()
		if global_position.distance_to(player.global_position) < FOLLOW_DISTANCE + 100:
			shoot()



func get_hit(damage: int) -> void:
	damage = weapon.damage
	health -= damage
	print("got hit")
	if health <= 0:
		queue_free()
	if player.position.x < global_position.x:
		global_position.x += 75
	elif player.position.x > global_position.x:
		global_position.x -= 75
		

func bomb():
	pass
	
func shoot():
	pass
