extends Area3D

@onready var weapon_impact: AudioStreamPlayer3D = $WeaponImpact
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_area_entered(_area: Area3D) -> void:
	print("Area entered!")
	weapon_impact.pitch_scale = randf_range(0.5, 2.0)
	weapon_impact.play()
	animation_player.play("impact")
