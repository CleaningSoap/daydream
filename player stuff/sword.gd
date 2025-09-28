extends Area2D

@export var slash_scene: PackedScene

@onready var pivot: Marker2D = $Pivot
@onready var sword: Area2D = $"."  
@onready var attack_speed: Timer = $"Attack speed"
@onready var slash_cd: Timer = $"Slash CD"
var player
const PLAYERPATH = "/root/Main/Player"
const MAINPATH = "/root/Main"
@onready var attack_range: CollisionShape2D = $"Attack Range"
@onready var slash_repeat_cd: Timer = $"Slash Repeat CD"

@onready var enemy: Node2D = $"."  
var can_attack = true
var can_slash = false
signal attack_damage(a_damage : int)
var damage = 25
var last_dir = 0  # Initialize last_dir here
var unlocked_slash = false
var slash_num = 0
var main
var slash_left = 0

func _ready():
	player = get_node(PLAYERPATH)
	main = get_node(MAINPATH)

func _physics_process(_delta):
	var dir = player.dir
			
	if dir != 0:  # Only update last_dir when the player moves
		last_dir = dir  
	if can_slash && unlocked_slash:
		if Input.is_action_just_pressed("slash_attack"):
			if last_dir == -1:  # Facing left
				rotation += 130
			elif last_dir == 1:  # Facing right
				rotation -= 130
				can_attack = false
				slash_cd.start()
			slash_left = slash_num
			_slash_attack()
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
	

func _on_slash_cd_timeout():
	if unlocked_slash:
		rotation = 0
		can_slash = true


func _slash_attack():
	var new_slash = slash_scene.instantiate()
	new_slash.global_position = %Slash_Point.global_position
	new_slash.direction = last_dir
	main.add_child(new_slash)
	slash_left -= 1
	if slash_left > 0:
		slash_repeat_cd.start()


func _on_button_pressed() -> void:
	scale *= 8
	attack_range.scale *= 8

func _on_button_2_pressed() -> void:
	damage += 20

func _on_button_3_pressed() -> void:
	unlocked_slash = true
	can_slash = true
	slash_num += 1


func _on_slash_repeat_cd_timeout() -> void:
	_slash_attack()
