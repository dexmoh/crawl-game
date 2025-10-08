# Class that tracks all player character data.

extends Node

var character: PlayerController
var inventory: Inventory

func _ready():
	# Spawn player character.
	character = preload("res://scenes/player.tscn").instantiate() as PlayerController
	add_child(character)

	# I hate this.
	# TODO: Fix this when you implement a save system.
	var spawner := get_tree().get_first_node_in_group("portal_spawn_marker") as PortalSpawnMarker
	character.global_position = spawner.global_position
	character.camera_pivot.rotation.y = spawner.rotation.y

	inventory = Inventory.new()
