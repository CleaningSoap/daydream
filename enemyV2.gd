extends CharacterBody2D

@onready var shoot_cooldown: Timer = $"../ShootCooldown"

signal hit_player(mob_damage : int)
var mob_damage = 20
@onready var attack_hitbox: Area2D = $"Attack Hitbox"
@onready var hitbox: Area2D = $"../../Player/Hitbox"

var player
var weapon
var main

const PLAYERPATH = "/root/Main/Player"
const WEAPONPATH = "/root/Main/Player/Sword"
const MAINPATH = "/root/Main"
const SPEED = 100
var enemy_type = "shooter" #can also be bomber or shooter
const FOLLOW_DISTANCE = 50
const EXPLODE_DISTANCE = 50

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(PLAYERPATH)
	weapon = get_node(WEAPONPATH)
	main = get_node(MAINPATH)
	
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
	
	var player_in_range = attack_hitbox.get_overlapping_bodies()
	for player in player_in_range:
		if player is Node2D and player.has_method("take_damage"):
			player.take_damage(mob_damage)
			hit_player.emit(mob_damage)



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

var can_shoot = true	
func shoot():
	if can_shoot:
		main.spawn_enemy(randi_range(global_position.x - 50, global_position.x + 50), randi_range(global_position.y - 50, global_position.y + 50),"chaser", 0.5)
		can_shoot = false
		shoot_cooldown.start()
	
func change_type(type):
	enemy_type = type

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
