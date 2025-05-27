extends Node3D

@onready var weapon_impact: AudioStreamPlayer3D = $WeaponImpact
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"

func _on_health_component_damaged(_info: AttackInfo, _current_health: int) -> void:
	weapon_impact.pitch_scale = randf_range(0.5, 2.0)
	weapon_impact.play()
	animation_player.play("impact")
