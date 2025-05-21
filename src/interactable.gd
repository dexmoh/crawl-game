# Abstract class for defining interactable objects.

class_name Interactable
extends CollisionObject3D

@export var label_text: String = "Interact":
	get:
		return label_text

# Called when the player tries to interact with the object.
# This function must be overriden in derived classes.
func interact(_src: Object):
	push_error("Function 'interact' should be overriden inside child class.")
