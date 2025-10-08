# Global autoload that contains and manages the state of the game.

extends Node

var _is_paused = false

func pause():
	_is_paused = true
	get_tree().paused = true

func unpause():
	_is_paused = false
	get_tree().paused = false

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
	
	Player.character.global_position = next_spawner.global_position
	Player.character.camera_pivot.rotation.y = next_spawner.rotation.y
