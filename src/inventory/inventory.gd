class_name Inventory
extends Resource

@export var items: Array[InventoryItem]
@export var max_carry_weight: float = 50.0
@export var wealth: int = 0

func add_item(item: InventoryItem):
	if item:
		items.append(item)
