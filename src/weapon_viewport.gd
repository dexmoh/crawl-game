extends SubViewport

@onready var weapon_camera: Camera3D = $WeaponCamera
@onready var main_camera: Camera3D = get_tree().get_first_node_in_group("main_camera")

func _process(_delta: float):
	weapon_camera.global_transform = main_camera.global_transform
