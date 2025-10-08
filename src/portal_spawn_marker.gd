# Node that marks the destination of a portal.
# Every portal marker is distinguished by an unique string ID.

class_name PortalSpawnMarker
extends Sprite3D

@export var id: String = "default"

func _ready():
	hide()
