# Abstract class for defining interactable objects.

class_name Interactable
extends CollisionObject3D

@export var label_text: String = "Interact"
@export var is_active: bool = true

func _ready():
	# Enable interaction mask.
	set_collision_layer_value(3, true)

# Called while the player is looking at the object.
func _on_focus():
	pass

# Called when the player tries to interact with the object.
func _interact():
	pass
