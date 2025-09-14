extends SubViewport

@export var viewport_height: int = 480

@onready var weapon_camera: Camera3D = $WeaponCamera
@onready var main_camera: Camera3D = get_tree().get_first_node_in_group("main_camera")
@onready var main_viewport: Viewport = get_tree().get_root().get_viewport()

func _ready():
	size.x = int((float(main_viewport.size.x) / float(main_viewport.size.y)) * float(viewport_height))
	size.y = viewport_height

	main_viewport.size_changed.connect(_on_vp_size_changed)

func _process(_delta: float):
	weapon_camera.global_transform = main_camera.global_transform

func _on_vp_size_changed():
	size.x = int((float(main_viewport.size.x) / float(main_viewport.size.y)) * float(viewport_height))
