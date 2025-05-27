extends CharacterBody3D

@export var movement_speed: float = 3.0

var red_mat: StandardMaterial3D = load("res://assets/materials/red_mat.res")

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mesh: MeshInstance3D = $Armature/Skeleton3D/Skeleton
@onready var hurt_timer: Timer = $HealthComponent/HurtTimer
@onready var bone_rattle_audio: AudioStreamPlayer3D = $BoneRattleAudio

func _ready():
	animation_player.play("dance")
	mesh.material_override = red_mat
	hurt_timer.start()

func _physics_process(_delta):
	var current_loc = global_transform.origin
	var next_loc = nav_agent.get_next_path_position()
	var new_velocity = (next_loc - current_loc).normalized() * movement_speed
	
	look_at(nav_agent.target_position)
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()

func update_target_location(target_loc):
	nav_agent.target_position = target_loc

func _on_target_reached() -> void:
	pass

func _on_health_component_damaged(_info: AttackInfo, _current_health: int) -> void:
	bone_rattle_audio.pitch_scale = randf_range(0.5, 2.0)
	bone_rattle_audio.play()
	mesh.material_override = red_mat
	hurt_timer.start()

func _on_health_component_died() -> void:
	animation_player.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

func _on_hurt_timer_timeout() -> void:
	mesh.material_override = null
