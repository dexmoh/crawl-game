# Display player's inventory screen.

extends Control

@export var item_container_scene: PackedScene

var items_list: Array[Control]

@onready var items_container: BoxContainer = %ItemsContainer
@onready var wealth_label: Label = %WealthLabel
@onready var weight_label: Label = %WeightLabel
@onready var item_search_bar: LineEdit = %ItemSearchBar

func _ready() -> void:
	item_search_bar.text_changed.connect(_on_search_bar_text_changed)
	hide()

func _input(event: InputEvent):
	# Handle window opening and closing.
	if event.is_action_pressed("inventory"):
		if visible:
			hide()
			item_search_bar.text = ""

			Game.clear_free_mouse_request()
			Game.clear_pause_request()
		else:
			show()
			_update_inventory()
			
			Game.request_free_mouse()
			Game.request_pause()

		get_viewport().set_input_as_handled()
	elif visible and event.is_action_pressed("ui_cancel"):
		hide()
		item_search_bar.text = ""

		Game.clear_free_mouse_request()
		Game.clear_pause_request()

		get_viewport().set_input_as_handled()

func _update_inventory():
	for child in items_container.get_children():
		items_container.remove_child(child)
		child.queue_free()
	
	var weight: float = 0.0

	for item: InventoryItem in Player.inventory.items:
		# Create a new item container and add it to the items list.
		var item_container := item_container_scene.instantiate() as InventoryItemContainerUI
		items_container.add_child(item_container)
		item_container.set_item_info(item)

		weight += item.get_total_weight()
	
	wealth_label.text = str(Player.inventory.wealth)
	weight_label.text = str(weight) + "/" + str(Player.inventory.max_carry_weight)

func _show_all_items():
	for item in items_container.get_children():
		item.show()

func _on_search_bar_text_changed(new_text: String):
	if not new_text:
		_show_all_items()
		return
	
	new_text = new_text.to_lower()
	
	for item in items_container.get_children():
		if item.name_label.text.to_lower().contains(new_text):
			item.show()
		else:
			item.hide()
