# Script for handling and displaying temporary floating
# notifications on top of the player's screen.

class_name NotificationBox
extends MarginContainer

const _NOTIF_DURATION_SEC: float = 3.0

var _notif_queue: Array[String]

@onready var _notif_label: Label = %NotificationLabel
@onready var _timer: Timer = %Timer

func _ready():
	hide()

	_notif_label.text = ""

	_timer.wait_time = _NOTIF_DURATION_SEC
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timout)

func _show_next_notif():
	if _notif_queue.is_empty():
		return
	
	_timer.start()
	_notif_label.text = _notif_queue.pop_front()
	
	show()


func _on_timer_timout():
	hide()

	if !_notif_queue.is_empty():
		_show_next_notif()

func queue_notification(notif_str: String):
	_notif_queue.push_back(notif_str)

	if _timer.is_stopped():
		_show_next_notif()
