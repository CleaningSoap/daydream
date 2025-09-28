extends Area2D
@onready var pivot: Marker2D = $Pivot
@onready var sword: Area2D = $"."

@onready var enemy: Node2D = $"."

signal attack_damage(a_damage : int)
var damage = 10

func _physics_process(_delta):
	if Input.is_action_just_pressed("attack"):
		var mobs_in_range = sword.get_overlapping_bodies()
		if (mobs_in_range.has_method("get_hit") == true):
			attack_damage.emit(damage)
			mobs_in_range.get_hit()
			
