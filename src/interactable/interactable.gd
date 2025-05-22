# Abstract class for defining interactable objects.

class_name Interactable
extends CollisionObject3D

@export var label_text: String = "Interact"
@export var is_active: bool = true

# Called while the player is looking at the object.
func on_focus(_src: Object):
	pass

# Called when the player tries to interact with the object.
func interact(_src: Object):
	pass
