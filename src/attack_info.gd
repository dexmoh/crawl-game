class_name AttackInfo
extends Object

var source: Node3D
var damage_amount: int

func _init(source_arg: Node3D = null, damage_amount_arg: int = 0) -> void:
	source = source_arg
	damage_amount = damage_amount_arg
