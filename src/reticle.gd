extends CenterContainer

@export var dot_radius: float = 2.0
@export var dot_color: Color = Color.WHITE

func _ready():
	queue_redraw()

func _draw():
	draw_circle(Vector2(20.0, 20.0), dot_radius, dot_color)
