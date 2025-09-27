extends Area2D
@onready var pivot: Marker2D = $Pivot
@onready var attack_range: CollisionShape2D = $"Attack Range"

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
