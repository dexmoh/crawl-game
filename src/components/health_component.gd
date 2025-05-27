class_name HealthComponent
extends Area3D

signal damaged(info: AttackInfo, current_health: int)
signal died

@export var max_health: int = 100
@export var invincible: bool = false

var current_health: int
var is_dead: bool = false

func _ready() -> void:
	current_health = max_health

func damage(info: AttackInfo) -> int:
	if is_dead:
		return current_health
	
	if invincible:
		emit_signal("damaged", info, current_health)
		return current_health
	
	current_health -= info.damage_amount
	emit_signal("damaged", info, current_health)
	
	if current_health <= 0:
		die()
	
	return current_health

func heal(amount: int) -> int:
	current_health += amount
	current_health = min(current_health, max_health)
	return current_health

func die():
	is_dead = true
	emit_signal("died")
