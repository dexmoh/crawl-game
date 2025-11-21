# Script for handling and displaying temporary floating
# notifications on top of the player's screen.

class_name NotificationBox
extends MarginContainer

const _DEFAULT_NOTIF_DURATION_SEC: float = 3.0

@onready var _notif_label: Label = %NotificationLabel
@onready var _timer: Timer = %Timer

func _ready():
	hide()

	_notif_label.text = ""

	_timer.wait_time = _DEFAULT_NOTIF_DURATION_SEC
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timout)

# Show a notification with a message on player's screen.
func send(
	notif_str: String,
	notif_duration_sec: float = _DEFAULT_NOTIF_DURATION_SEC
):
	if not notif_str:
		return

	_timer.wait_time = notif_duration_sec
	_timer.start()
	_notif_label.text = notif_str
	
	show()

func _on_timer_timout():
	hide()
