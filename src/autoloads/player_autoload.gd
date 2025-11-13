# Class that tracks all player character data.

extends Node

var body: PlayerController
var inventory: Inventory

func _ready():
	body = get_tree().get_first_node_in_group("player") as PlayerController
	inventory = Inventory.new()
