# Health component used to manage entity's health and handle damage.

class_name  HealthComponent
extends Area3D

signal damaged(damage_received: int, current_health: int)
signal died

@export var max_health: int = 100
@export var invincible: bool = false

@export_group("Damage Material")
@export var mesh: MeshInstance3D
@export var damage_mat: StandardMaterial3D
@export var mat_timer: float = 0.5

var is_dead: bool = false

@onready var current_health: int = max_health

func _ready() -> void:
	monitoring = false

func damage(amount: int) -> int:
	if is_dead:
		return current_health

	if invincible:
		damaged.emit(0, current_health)
	else:
		current_health -= amount
		damaged.emit(amount, current_health)

	if current_health <= 0:
		die()
	
	# Flash the mesh.
	if mesh and damage_mat:
		mesh.material_override = damage_mat

		var timer := get_tree().create_timer(mat_timer)
		timer.timeout.connect(
			func ():
				mesh.material_override = null
		)

	return current_health

func heal(amount: int) -> int:
	current_health += amount
	current_health = min(current_health, max_health)

	return current_health

func die():
	is_dead = true
	died.emit()
