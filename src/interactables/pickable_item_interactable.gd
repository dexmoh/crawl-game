extends Interactable

@export var item: InventoryItem

func _ready():
	if !item:
		push_error("Pickable item wasn't given an item resource, player can't pick this item up!")
	else:
		label_text = "Pick up: " + item.name
	
	super._ready()

# Add the item to player's inventory.
func _interact():
	if item:
		# Message box test (temporary).
		GUI.message_box.queue_message("You pick up [" + item.name + "].")
		
		Player.inventory.add_item(item)
	
	hide()
	queue_free()
