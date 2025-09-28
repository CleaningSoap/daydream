extends Area2D
@onready var pivot: Marker2D = $Pivot
@onready var attack_range: CollisionShape2D = $"Attack Range"
@onready var enemy: Node2D = $"."



#func _physics_process(delta: float):
	
#	if Input_is_just_pressed("attack"):
	




func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
