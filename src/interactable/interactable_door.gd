extends Interactable

@export var is_open: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_open_audio: AudioStreamPlayer3D = $DoorOpenAudio
@onready var door_close_audio: AudioStreamPlayer3D = $DoorCloseAudio

func _ready() -> void:
	if is_open:
		rotate_y(deg_to_rad(-85.0))

func interact(_src: Object) -> void:
	if animation_player.is_playing():
		return
	
	is_active = false
	
	if not is_open:
		# Open the door.
		door_open_audio.play()
		animation_player.play("door_open")
		label_text = "Close"
		is_open = true
	else:
		# Close the door.
		door_close_audio.play()
		animation_player.play_backwards("door_open")
		label_text = "Open"
		is_open = false

func _on_animation_finished(anim_name: StringName) -> void:
	is_active = true
