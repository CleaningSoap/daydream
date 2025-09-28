extends Area2D

@onready var pivot: Marker2D = $Pivot
@onready var sword: Area2D = $"."  
@onready var attack_speed: Timer = $"Attack speed"

var player
const PLAYERPATH = "/root/Main/Player"

@onready var enemy: Node2D = $"."  
var can_attack = true
signal attack_damage(a_damage : int)
var damage = 25
var last_dir = 0  # Initialize last_dir here

func _ready():
	player = get_node(PLAYERPATH)

func _physics_process(_delta):
	var dir = player.dir
			
	if dir != 0:  # Only update last_dir when the player moves
		last_dir = dir  
	if can_attack:
		if Input.is_action_just_pressed("attack"):


			if last_dir == -1:  # Facing left
				rotation += 130
			elif last_dir == 1:  # Facing right
				rotation -= 130
				
			print(last_dir)  # Print the current direction
			can_attack = false
			attack_speed.start()
			
			# Deal damage to enemies in range
			var mobs_in_range = sword.get_overlapping_bodies()
			for mob in mobs_in_range:
				if mob is Node2D and mob.has_method("get_hit"):  
					mob.get_hit(damage)
					attack_damage.emit(damage)

func _on_attack_speed_timeout() -> void:
	# Reset sword rotation after cooldown
	rotation = 0  # Neutral position after swing
	can_attack = true
