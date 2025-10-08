class_name InventoryItemContainerUI
extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var name_label: Label = %NameLabel
@onready var type_label: Label = %TypeLabel
@onready var value_label: Label = %ValueLabel
@onready var weight_label: Label = %WeightLabel

func set_item_info(item: InventoryItem):
	icon.texture = item.icon
	name_label.text = item.name
	name_label.modulate = Color(item.rarity)
	type_label.text = item.type_to_str()
	value_label.text = str(item.value)
	weight_label.text = str(item.weight)
