extends RayCast3D

@onready var interaction_label = $InteractionLabel

func _physics_process(_delta: float):
	# Handle interactions.
	interaction_label.text = ""
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable and collider.is_active:
			collider.on_focus()
			interaction_label.text = "[E] " + collider.label_text
			
			if Input.is_action_just_pressed("interact"):
				collider.interact()
