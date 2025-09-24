extends Interactable

@export var item: InventoryItem

func _ready():
	if !item:
		push_error("Error: Pickable item wasn't given an item resource, player can't pick this item up!")
	else:
		label_text = "Pick up: " + item.name

# Add the item to player's inventory.
func _interact():
	if item:
		Player.inventory.add_item(item)
	
	hide()
	queue_free()
