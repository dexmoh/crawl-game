# Global autoload that contains and manages the state of the game.

extends Node

var _is_paused = false

func pause():
	_is_paused = true
	get_tree().paused = true

func unpause():
	_is_paused = false
	get_tree().paused = false
