# Attach this script to a MeshInstance to give the mesh a medium outline.

class_name MediumMeshOutline
extends MeshInstance3D

const outline_mat: StandardMaterial3D = preload("res://data/materials/simple/outlines/medium_outline_mat.tres")

func _enter_tree():
	cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	gi_mode = GeometryInstance3D.GI_MODE_DISABLED

	visibility_range_end = 5.0
	visibility_range_end_margin = 1.0
	visibility_range_fade_mode = GeometryInstance3D.VISIBILITY_RANGE_FADE_SELF

	material_override = outline_mat

	show()
