extends CharacterBody2D

@onready var shoot_cooldown: Timer = $"../ShootCooldown"

signal hit_player(mob_damage : int)
var mob_damage = 100
@onready var attack_hitbox: Area2D = $"Attack Hitbox"

var player
var weapon
var main

const PLAYERPATH = "/root/Main/Player"
const WEAPONPATH = "/root/Main/Player/Sword"
const MAINPATH = "/root/Main"

var health = 10000

var startx
var starty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(PLAYERPATH)
	weapon = get_node(WEAPONPATH)
	main = get_node(MAINPATH)
	
	startx = global_position.x
	starty = global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if global_position.x != startx:
		global_position.x = startx
	if global_position.y != starty:
		global_position.y = starty
	
func get_hit(damage: int) -> void:
	damage = weapon.damage
	health -= damage
	print("got hit")
	if health <= 0:
		main.killed_enemy()
		queue_free()
	if player.position.x < global_position.x:
		global_position.x += 75
	elif player.position.x > global_position.x:
		global_position.x -= 75
		
