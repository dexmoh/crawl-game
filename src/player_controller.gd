extends CharacterBody3D

@export_group("Movement")
@export_range(0, 30, 0.5) var walk_speed: float = 3.0
@export_range(0, 30, 0.5) var sprint_speed: float = 8.0
@export var jump_velocity: float = 4.5

@export_group("Camera Controls")
@export_range(0, 0.02, 0.001) var mouse_sensitivity: float = 0.004
@export_range(0, 110, 5) var vertical_camera_clamp: float = 85.0
@export var head_bob_enabled: bool = true
@export var head_bob_frequency: float = 2.0
@export var head_bob_amplitude: float = 0.08

var head_bob_t: float = 0.0

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Handle sprinting.
	var current_speed: float = walk_speed
	if (Input.is_action_pressed("sprint")):
		current_speed = sprint_speed
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (camera_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
		
		# Handle movement.
		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			# Slow down gradually.
			velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 7.0)
		
	else:
		# Add the gravity.
		velocity += get_gravity() * delta
		
		# Keep velocity while falling.
		velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 3.0)
	
	# Head bob.
	if head_bob_enabled:
		head_bob_t += velocity.length() * float(is_on_floor()) * delta
		
		var head_bob_position: Vector3 = Vector3.ZERO
		head_bob_position.x = cos(head_bob_t * head_bob_frequency / 2) * head_bob_amplitude
		head_bob_position.y = sin(head_bob_t * head_bob_frequency) * head_bob_amplitude
		
		camera.transform.origin = head_bob_position
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
