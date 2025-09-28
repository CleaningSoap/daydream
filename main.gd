extends Node

@export var enemy_scene: PackedScene

var player

const PLAYERPATH = "/root/Main/Player"

var difficulty = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(PLAYERPATH)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_difficulty_timeout() -> void:
	difficulty += 1

func _on_enemy_spawn_timeout() -> void:
	
	spawn_enemy(randi_range(player.position.x + 500, player.position.x + 1000),randi_range(player.position.y - 200, player.position.y - 500),"shooter")
	

func spawn_enemy(enemy_x :int,enemy_y:int,enemy_type = "chaser", enemy_scale = 1, enemy_speed = 1, enemy_health = 100, enemy_damage = 20):
	var enemy = enemy_scene.instantiate()
	enemy.global_position.x = enemy_x
	enemy.global_position.y = enemy_y
	enemy.scale *= enemy_scale
	var body2d = enemy.get_node("CharacterBody2D")
	body2d.change_type(enemy_type) 
	body2d.change_health(enemy_health)
	body2d.change_speed(enemy_speed)
	body2d.change_damage(enemy_damage)
	
	# Spawn the mob by adding it to the Main scene.
	print("Enemy Spawned")
	add_child(enemy)
