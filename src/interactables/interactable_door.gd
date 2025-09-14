extends Interactable

@export var is_open: bool = false

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.animation_finished.connect(_on_animation_finished)
	
	if is_open:
		anim_player.play("open_and_close")
		label_text = "Close"
	else:
		label_text = "Open"

func interact():
	if anim_player.is_playing():
		return
	
	is_active = false
	
	if not is_open:
		# Open the door.
		anim_player.play("open_and_close")
		label_text = "Close"
		is_open = true
	else:
		# Close the door.
		anim_player.play_backwards("open_and_close")
		label_text = "Open"
		is_open = false

func _on_animation_finished(_anim_name: StringName):
	is_active = true
