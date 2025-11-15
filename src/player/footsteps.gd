extends Node3D

var footsteps: Array[AudioStreamPlayer3D]

func _ready() -> void:
	for child in get_children():
		if child is AudioStreamPlayer3D:
			footsteps.append(child)

func play_random_foostep():
	var footstep: AudioStreamPlayer3D = footsteps.pick_random()
	footstep.pitch_scale = randf_range(0.9, 1.1)
	footstep.play()
