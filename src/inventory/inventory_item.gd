class_name InventoryItem
extends Resource

enum Type {
	WEAPON,
	APPAREL,
	FOOD,
	INGREDIENT,
	POTION,
	KEY,
	QUEST_ITEM,
	MISC
}

enum Rarity {
	LEGENDARY = 0xff8000ff,
	EPIC = 0xa335eeff,
	RARE = 0x0070ddff,
	UNCOMMON = 0x1eff00ff,
	COMMON = 0xffffffff,
	POOR = 0x9d9d9dff
}

@export var name: String = "Item"
@export_multiline var description: String
@export var type: Type = Type.MISC
@export var rarity: Rarity = Rarity.COMMON
@export var icon: Texture2D
@export var weight: float = 1.0
@export var value: int = 0
@export var can_stack: bool = false
@export var amount: int = 1

func get_total_weight() -> float:
	return weight * float(amount)

func type_to_str() -> String:
	match type:
		Type.WEAPON:
			return "Weapon"
		Type.APPAREL:
			return "Apparel"
		Type.FOOD:
			return "Food"
		Type.INGREDIENT:
			return "Ingredient"
		Type.POTION:
			return "Potion"
		Type.KEY:
			return "Key"
		Type.QUEST_ITEM:
			return "Quest Item"
		Type.MISC:
			return "Misc"
		_:
			return "Misc"
