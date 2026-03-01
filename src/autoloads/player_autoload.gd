# Class that tracks all player character data.

extends Node

var body: PlayerController

func _ready():
	body = get_tree().get_first_node_in_group("player") as PlayerController
