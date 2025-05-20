extends Node3D

var attack_animations: Array = ["weapon_attack_1", "weapon_attack_2"]

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var hitbox: Area3D = $"../Camera/Hitbox"
@onready var camera: Camera3D = $"../Camera"
@onready var weapon_swing_1: AudioStreamPlayer = $"../../WeaponSwing1"
@onready var weapon_swing_2: AudioStreamPlayer = $"../../WeaponSwing2"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if animation_player.current_animation == "weapon_idle":
			hitbox.monitorable = true
			var next_animation = attack_animations.pick_random()
			animation_player.play(next_animation)
			
			if next_animation == "weapon_attack_1":
				weapon_swing_1.play()
			else:
				weapon_swing_2.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var camera_rotation: float = camera.rotation_degrees.x
	if camera_rotation < -20.0:
		rotation_degrees.x = camera_rotation + 20.0
	else:
		rotation_degrees.x = 0.0

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "RESET":
		animation_player.play("weapon_idle")
	else:
		hitbox.monitorable = false
		animation_player.play("RESET")
