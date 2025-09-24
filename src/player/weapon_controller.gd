extends Node3D

@export var rotation_upper_clamp: float = 30.0
@export var rotation_bottom_clamp: float = -10.0

const melee_attack_anims: Array[StringName] = ["melee_attack_1", "melee_attack_2", "melee_attack_3", "melee_attack_4"]

@onready var camera_pivot: Node3D = $"../CameraPivot"
@onready var camera: Node3D = $"../CameraPivot/Camera"
@onready var anim_player: AnimationPlayer = $WeaponAnimationPlayer
@onready var melee_hitbox: Area3D = %MeleeHitbox

func _ready():
	rotation_upper_clamp = deg_to_rad(rotation_upper_clamp)
	rotation_bottom_clamp = deg_to_rad(rotation_bottom_clamp)
	melee_hitbox.monitoring = true

	anim_player.animation_finished.connect(_on_animation_finished)

func _process(_delta: float):
	# Fix position and rotation to the camera.
	transform = camera_pivot.transform

	if camera.rotation.x < rotation_bottom_clamp:
		rotation.x = camera.rotation.x - rotation_bottom_clamp
	elif camera.rotation.x > rotation_upper_clamp:
		rotation.x = camera.rotation.x - rotation_upper_clamp
	
	# Handle attack input.
	if Input.is_action_just_pressed("attack"):
		if anim_player.current_animation == "idle":
			anim_player.play(melee_attack_anims.pick_random())
			
			for area in melee_hitbox.get_overlapping_areas():
				if area is HealthComponent:
					area.damage(30)

func _on_animation_finished(anim_name: StringName):
	if anim_name != "idle":
		anim_player.play("idle")
