extends Node

@export var enemy_scene: PackedScene
@onready var win_screen: CanvasLayer = $WinScreen

var player

var enemy_killed = 0
var heal_quota = 0

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
	
	var enemy_scale
	var enemy_health
	var enemy_speed
	var enemy_damage
	
	var enemy_type = randi_range(1,3)
	if enemy_type == 2:
		enemy_type = "shooter"
		enemy_scale = 1.5
		enemy_health = 200
		enemy_speed = 0.5
		enemy_damage = 0
	elif enemy_type == 3:
		enemy_type = "bomber"
		enemy_scale = 0.75
		enemy_health = 50
		enemy_speed = 3
		enemy_damage = 50
	else:
		enemy_type = "chaser"
		enemy_scale = 1
		enemy_health = 100
		enemy_speed = 1
		enemy_damage = 10
	
	enemy_health *= difficulty
	enemy_damage *= (difficulty/2+0.5)
	enemy_scale *= (difficulty/3+0.67)
	
	spawn_enemy(randi_range(player.position.x + 500, player.position.x + 1000),randi_range(player.position.y - 200, player.position.y - 500),enemy_type, enemy_scale, enemy_speed, enemy_health, enemy_damage)
	

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

var heal_amount = 100
func killed_enemy():
	enemy_killed += 1
	heal_quota += 1
	if heal_quota >= 10 :
		player.heal(heal_amount)
		heal_amount *=2
		heal_quota = 0
	
	
func win_game():
	get_tree().paused = true
	win_screen.visible = true


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	get_tree().quit()
