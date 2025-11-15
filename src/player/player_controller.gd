class_name PlayerController
extends CharacterBody3D

const VERT_CAM_CLAMP: float = 90.0
const CROUCH_ANIM_SPEED: float = 6.0
const HEAD_BOB_FREQUENCY: float = 1.8
const HEAD_BOB_AMPLITUDE: float = 0.05

@export_group("Movement")
@export_range(1, 30, 0.5) var walk_speed: float = 3.0
@export_range(1, 30, 0.5) var sprint_speed: float = 6.0
@export_range(1, 30, 0.5) var crouch_speed: float = 1.5
@export_range(1, 20, 0.25) var jump_velocity: float = 4.0

@export_group("Camera Controls")
@export_range(0, 1.0, 0.05) var mouse_sensitivity: float = 0.5
@export var head_bob_enabled: bool = true

var can_move: bool = true
var can_look_around: bool = true
var is_crouching: bool = false

var _crouch_key_released: bool = false
var _head_bob_t: float = 0.0

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera
@onready var crouch_anim_player: AnimationPlayer = $CrouchAnimationPlayer
@onready var crouch_shape_cast: ShapeCast3D = $CrouchShapeCast

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	camera_pivot.rotation.y = global_rotation.y
	global_rotation.y = 0.0

func _physics_process(delta: float) -> void:
	if can_move:
		# Handle crouch.
		if Input.is_action_just_pressed("crouch"):
			if !_crouch_key_released:
				crouch_anim_player.play("crouch", -1, CROUCH_ANIM_SPEED)
			_crouch_key_released = false
			is_crouching = true
		elif Input.is_action_just_released("crouch"):
			_crouch_key_released = true
		
		if _crouch_key_released:
			crouch_shape_cast.force_shapecast_update()
			if !crouch_shape_cast.is_colliding():
				crouch_anim_player.play("crouch", -1, -CROUCH_ANIM_SPEED, true)
				_crouch_key_released = false
				is_crouching = false

		# Handle sprinting.
		var current_speed: float = walk_speed
		if is_crouching:
			current_speed = crouch_speed
		elif (Input.is_action_pressed("sprint")):
			current_speed = sprint_speed
		
		# Get the input direction and handle the movement/deceleration.
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (camera_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if is_on_floor():
			# Handle jump.
			if Input.is_action_just_pressed("jump") and !is_crouching:
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
		_head_bob_t += velocity.length() * float(is_on_floor()) * delta
		
		var head_bob_position: Vector3 = Vector3.ZERO
		head_bob_position.x = cos(_head_bob_t * HEAD_BOB_FREQUENCY / 2) * HEAD_BOB_AMPLITUDE
		head_bob_position.y = sin(_head_bob_t * HEAD_BOB_FREQUENCY) * HEAD_BOB_AMPLITUDE
		
		camera.transform.origin = head_bob_position
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion) and can_look_around:
		camera.rotate_x(-event.relative.y * mouse_sensitivity / 100.0)
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity / 100.0)
		
		camera.rotation_degrees.x = clamp(
			camera.rotation_degrees.x,
			-VERT_CAM_CLAMP,
			VERT_CAM_CLAMP
		)
