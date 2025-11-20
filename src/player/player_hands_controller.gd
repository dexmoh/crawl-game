extends Node3D

const _VERT_SWAY_LIMIT_DEG: float = 20.0
const _VERT_SWAY_SPEED: float = 5.0

@onready var _anim_player: AnimationPlayer = %AnimationPlayer
@onready var _camera: Camera3D = get_tree().get_first_node_in_group("main_camera")

@onready var _ohm_attack_anims: Dictionary[StringName, AudioStreamPlayer3D] = {
	"ohm_attack_top" : %WeaponSwing1SFX,
	"ohm_attack_bottom" : %WeaponSwing3SFX,
	"ohm_attack_left" : %WeaponSwing2SFX,
	"ohm_attack_right" : %WeaponSwing4SFX
}

var _camera_offset: Transform3D
var _current_sway_pitch: float = 0.0

func _ready():
	_anim_player.animation_finished.connect(_on_animation_finished)
	_camera_offset = _camera.global_transform.affine_inverse() * global_transform

func _process(delta: float):
	# Rotate and move the hands relative to the main camera.
	# This achieves the same effect as if the hands were
	# actually parented to the camera.
	global_transform = _camera.global_transform * _camera_offset

	# Apply vertical lag to the hands rotation,
	# so they don't look like they're fixed to the camera.
	var cam_pitch = _camera.rotation_degrees.x

	_current_sway_pitch = lerp(
		_current_sway_pitch,
		cam_pitch,
		delta * _VERT_SWAY_SPEED
	)

	_current_sway_pitch = clamp(
		_current_sway_pitch,
		cam_pitch - _VERT_SWAY_LIMIT_DEG,
		cam_pitch + _VERT_SWAY_LIMIT_DEG
	)

	rotation_degrees.x = _current_sway_pitch

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		if _anim_player.current_animation.contains("attack"):
			return
		
		_current_sway_pitch = 0.0

		var rand_anim: StringName = _ohm_attack_anims.keys().pick_random()
		_anim_player.play(rand_anim)

		# Play an attack sound.
		var sound: AudioStreamPlayer3D = _ohm_attack_anims[rand_anim]
		sound.pitch_scale = randf_range(0.9, 1.1)
		sound.play()

func _on_animation_finished(_anim_name: StringName):
	_anim_player.play("ohm_idle")
