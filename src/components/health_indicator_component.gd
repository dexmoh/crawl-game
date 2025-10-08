extends Sprite3D

@export var health_component: HealthComponent

@onready var progress_bar: ProgressBar = $SubViewport/Panel/ProgressBar
@onready var timer: Timer = $Timer

func _ready():
	if !health_component:
		push_warning("Health indicator wasn't given a health component to listen to!")
		queue_free()
		return
	
	hide()
	progress_bar.value = float(health_component.current_health) / float(health_component.max_health) * 100.0

	health_component.damaged.connect(_on_damaged)
	timer.timeout.connect(_on_timeout)

func _on_damaged(_damage_received, current_health):
	progress_bar.value = float(current_health) / float(health_component.max_health) * 100.0
	timer.start()
	show()

func _on_timeout():
	hide()
