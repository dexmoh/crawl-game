extends CharacterBody3D

@export var movement_speed: float = 3.0
@export var roam_radius: float = 15.0

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var light: OmniLight3D = $OmniLight3D

func _ready() -> void:
	set_physics_process(false)
	call_deferred("setup")

func setup() -> void:
	await get_tree().process_frame
	set_physics_process(true)
	nav_agent.set_target_position(get_random_point())

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		nav_agent.set_target_position(get_random_point())
	
	var next_pos = nav_agent.get_next_path_position()
	var direction = (next_pos - global_position)
	direction.y = 0
	
	light.light_color.h = light.light_color.h + 0.01
	if light.light_color.h >= 1.0:
		light.light_color.h = 0.0
	
	velocity = direction.normalized() * movement_speed
	move_and_slide()

func get_random_point() -> Vector3:
	var origin = global_position
	var random_offset = Vector3(
		randf_range(-roam_radius, roam_radius),
		0.0,
		randf_range(-roam_radius, roam_radius)
	)
	
	return NavigationServer3D.map_get_closest_point(
		nav_agent.get_navigation_map(),
		origin + random_offset
	)
