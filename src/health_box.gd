extends MeshInstance3D

@export var damaged_mat: StandardMaterial3D

@onready var health_comp: HealthComponent = $HealthComponent

func _ready():
	health_comp.damaged.connect(_on_damaged)

func _on_damaged(_damage_received: float, _current_health: float):
	material_override = damaged_mat

	var timer := get_tree().create_timer(0.5)
	timer.timeout.connect(
		func ():
			material_override = null
	)
