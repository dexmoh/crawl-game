extends Interactable

var colors: Array[Color] = [
	Color(1.0, 0.0, 0.0, 1.0),
	Color(0.0, 1.0, 0.0, 1.0),
	Color(0.0, 0.0, 1.0, 1.0),
	Color(1.0, 1.0, 0.0, 1.0),
	Color(0.0, 1.0, 1.0, 1.0),
	Color(1.0, 0.0, 1.0, 1.0),
]

@onready var mesh: MeshInstance3D = $MeshInstance3D

func interact(_src: Object) -> void:
	mesh.get_active_material(0).albedo_color = colors.pick_random()
