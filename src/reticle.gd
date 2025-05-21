extends CenterContainer

@export var reticle_radius: float = 2.0
@export var reticle_color: Color = Color.WHITE

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(20.0, 20.0), reticle_radius, reticle_color)
