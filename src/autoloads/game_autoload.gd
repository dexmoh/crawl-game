# Global autoload that contains and manages the state of the game.

extends Node

var is_paused: bool = false
var mouse_captured: bool = true

var _pause_request_counter: int = 0
var _free_mouse_request_counter: int = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Request the game to be paused.
func request_pause():
	_pause_request_counter += 1

	if !is_paused:
		is_paused = true
		get_tree().paused = true

# Clear the pause request.
# The game will unpause once all pause requests have been cleared.
func clear_pause_request():
	_pause_request_counter -= 1

	if _pause_request_counter <= 0:
		_pause_request_counter = 0
		
		is_paused = false
		get_tree().paused = false

# Request the mouse to be free and visible.
func request_free_mouse():
	_free_mouse_request_counter += 1

	if mouse_captured:
		mouse_captured = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Clear the free mouse request.
# The game will capture the mouse once all the requests have been cleared.
func clear_free_mouse_request():
	_free_mouse_request_counter -= 1

	if _free_mouse_request_counter <= 0:
		_free_mouse_request_counter = 0

		mouse_captured = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# TODO: This needs rework.
func change_current_level(new_level_path: String, spawn_marker_id: String = "default"):
	get_tree().change_scene_to_file(new_level_path)
	await get_tree().scene_changed

	# Look for the correct portal spawner.
	var next_spawner: PortalSpawnMarker
	var default_spawner: PortalSpawnMarker
	for spawner: PortalSpawnMarker in get_tree().get_nodes_in_group("portal_spawn_marker"):
		if spawner.id == spawn_marker_id:
			next_spawner = spawner
			break
		elif spawner.id == "default":
			default_spawner = spawner
	
	if not next_spawner:
		next_spawner = default_spawner
	
	Player.body.global_position = next_spawner.global_position
	Player.body.camera_pivot.rotation.y = next_spawner.rotation.y
