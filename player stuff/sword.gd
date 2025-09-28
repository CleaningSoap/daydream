extends Area2D
@onready var pivot: Marker2D = $Pivot
@onready var sword: Area2D = $"."

@onready var enemy: Node2D = $"."

signal attack_damage(a_damage : int)
var damage = 10

func _physics_process(_delta):
	if Input.is_action_just_pressed("attack"):
		var mobs_in_range = sword.get_overlapping_bodies()
		for mob in mobs_in_range:
			if mob is Node2D and mob.has_method("get_hit"):  
				mob.get_hit(damage)  
				attack_damage.emit(damage)
			rotation += 90
	
			
			
