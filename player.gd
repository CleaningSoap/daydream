extends CharacterBody2D

const SPEED = 600
const JUMP_VELOCITY = -900
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var spike_tilemap: Node2D = get_node("../SpikeTileMap")
@onready var bounce_tilemap: Node2D = get_node("../BounceTileMap")

func die():
	get_tree().reload_current_scene()

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal input
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Move with slide (Godot 4 version: no arguments)
	move_and_slide()

	# Check collisions after move
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == spike_tilemap:
			die()
		elif collider == bounce_tilemap:
			velocity.y = JUMP_VELOCITY * 1.5

	# Fall off map
	if position.y > 1000:
		die()
		
