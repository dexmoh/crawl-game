# Class that tracks all player character data.

extends Node

var character: PlayerController
var inventory: Inventory

func _ready():
	inventory = Inventory.new()
