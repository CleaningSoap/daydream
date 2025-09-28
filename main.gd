extends Node

@export var enemy_scene: PackedScene

var player

const PLAYERPATH = "/root/Main/Player"

var difficulty = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(PLAYERPATH)
	$Difficulty.start() 
	$EnemySpawn.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_difficulty_timeout() -> void:
	difficulty += 1

func _on_enemy_spawn_timeout() -> void:
	for i in range(difficulty):
		var enemy = enemy_scene.instantiate()
		enemy.position.x = randi_range(player.position.x + 500, player.position.x + 1000)
		enemy.position.y = randi_range(player.position.y - 300, player.position.y + 300)
		
		# Spawn the mob by adding it to the Main scene.
		add_child(enemy)
