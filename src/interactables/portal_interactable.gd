class_name PortalInteractable
extends Interactable

@export_file("*.tscn") var level_path: String
@export var destination_name: String = "World"
@export var spawn_marker_id: String = "default"

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var open_sfx: AudioStreamPlayer3D = $OpenSFX

func _ready():
	if not level_path:
		push_error("Portal interactable wasn't given a level path string, the portal can't funcion.")
		is_active = false
	
	if (not spawn_marker_id) || (spawn_marker_id == "default"):
		push_warning("Portal interactable wasn't given a marker id, default marker will be used.")
		spawn_marker_id = "default"
	
	label_text = "Go to: " + destination_name

	anim_player.animation_finished.connect(_on_animation_finished)

func _interact():
	if anim_player.is_playing():
		return
	
	is_active = false
	anim_player.play("open")
	open_sfx.play()

func _on_animation_finished(_anim_name: StringName):
	# Query the game to change the level.
	Game.change_current_level(level_path, spawn_marker_id)
