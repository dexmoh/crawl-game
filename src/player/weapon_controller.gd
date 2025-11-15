extends Node3D

const MELEE_ATTACK_ANIMS: Array[String] = [
	"melee_attack_1",
	"melee_attack_2",
	"melee_attack_3",
	"melee_attack_4"
]

@export var rotation_upper_clamp: float = 30.0
@export var rotation_bottom_clamp: float = -10.0

@onready var camera_pivot: Node3D = $"../CameraPivot"
@onready var camera: Node3D = $"../CameraPivot/Camera"
@onready var anim_player: AnimationPlayer = $WeaponAnimationPlayer
@onready var melee_ray: RayCast3D = %MeleeRay

func _ready():
	rotation_upper_clamp = deg_to_rad(rotation_upper_clamp)
	rotation_bottom_clamp = deg_to_rad(rotation_bottom_clamp)

	anim_player.animation_finished.connect(_on_animation_finished)

func _process(_delta: float):
	# Fix position and rotation to the camera.
	transform = camera_pivot.transform

	if camera.rotation.x < rotation_bottom_clamp:
		rotation.x = camera.rotation.x - rotation_bottom_clamp
	elif camera.rotation.x > rotation_upper_clamp:
		rotation.x = camera.rotation.x - rotation_upper_clamp

func _physics_process(_delta: float):
	# Handle attack input.
	if Input.is_action_just_pressed("attack"):
		if anim_player.current_animation == "idle":
			anim_player.play(MELEE_ATTACK_ANIMS.pick_random())
			
			melee_ray.force_raycast_update()

			if melee_ray.get_collider() is HealthComponent:
				melee_ray.get_collider().damage(30)

func _on_animation_finished(anim_name: StringName):
	if anim_name != "idle":
		anim_player.play("idle")
