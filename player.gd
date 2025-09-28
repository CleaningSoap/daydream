extends CharacterBody2D

const SPEED = 500
const JUMP_VELOCITY = -1000
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal hit_player(mob_damage : int)
var mob_damage = 20
@onready var button_3: Button = $"../CanvasLayer/ColorRect/Label3/Button3"

@onready var spike_tilemap: Node2D = get_node("../SpikeTileMap")
@onready var bounce_tilemap: Node2D = get_node("../BounceTileMap")
@onready var ice_tilemap: Node2D = get_node("../IceTileMap")
@onready var sprite: Sprite2D = $Sprite2D
@onready var sword: Area2D = $Sword
@onready var i_frame: Timer = $I_frame
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

var health = 100.0
const HPBARPATH = "/root/Main/Player/ProgressBar"
const MAINPATH = "/root/Main"
var progress_bar

var dir
var main

func _ready():
	progress_bar = get_node(HPBARPATH)
	main = get_node(MAINPATH)
	
func die():
	if get_tree():
		call_deferred("_go_to_game_over")

func _go_to_game_over():
	get_tree().change_scene_to_file("res://GameOver.tscn")


func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal input
	dir = Input.get_axis("left", "right")
	
	if dir != 0:
		sprite.scale.x = dir
		sword.scale.x = dir
	if dir == -1:
		sword.position.x = -abs(sword.position.x)
	elif dir == 1:
		sword.position.x = abs(sword.position.x)
	
	if dir != 0:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Check collisions after move
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == spike_tilemap:
			take_damage(5)
		elif collider == bounce_tilemap:
			velocity.y = JUMP_VELOCITY * 1.5
		elif collider == ice_tilemap:
			velocity.x = dir * SPEED * 1.6
	if Input.is_action_just_pressed("open_hp_sacrifice"):
		if main.enemy_killed >= 5:
			main.enemy_killed -= 5
			get_tree().paused = true
			canvas_layer.visible = true
		
	move_and_slide()
	# Move with slide (Godot 4 version: no arguments)d
	
	# Fall off map
	if position.y > 2000:
		die()
	
var invincible = false

func take_damage(mob_damage):
	if not invincible:
		print("taking damage")
		health -= mob_damage 
		if health <= 0:
			die()
		progress_bar.value = health
		invincible = true
		i_frame.start()
		
		
func _on_i_frame_timeout() -> void:
	invincible = false # Replace with function body.


func _on_button_2_pressed() -> void:
	health -= 25
	progress_bar.value = health
	get_tree().paused = false
	canvas_layer.visible = false

func _on_button_pressed() -> void:
	health -= 15
	progress_bar.value = health
	get_tree().paused = false
	canvas_layer.visible = false;


func _on_button_3_pressed() -> void:
	health -= 25
	progress_bar.value = health
	get_tree().paused = false
	canvas_layer.visible = false

func heal(heal_amount:int):
	health += heal_amount
