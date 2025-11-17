class_name MessageBox
extends PanelContainer

var _message_queue: Array[String]

@onready var _message_label: Label = %MessageLabel
@onready var _ok_btn: Button = %OkBtn

func _ready():
	hide()
	_message_label.text = ""
	_ok_btn.pressed.connect(_exit_message_box)

func _process(_delta: float):
	if !visible and !_message_queue.is_empty():
		_show_next_message()

func _input(event: InputEvent):
	if visible and (event is not InputEventMouse):
		if event.is_action_pressed("ui_cancel"):
			_exit_message_box()
		
		get_viewport().set_input_as_handled()

# Display the next message in the queue.
func _show_next_message():
	if _message_queue.is_empty():
		return

	Game.request_pause()
	Game.request_free_mouse()

	var message: String = _message_queue.pop_front()
	_message_label.text = message

	show()

# Hide the message box and continue the game.
func _exit_message_box():
	Game.clear_pause_request()
	Game.clear_free_mouse_request()

	hide()

# Add a message to the queue to be displayed.
func queue_message(message: String):
	_message_queue.push_back(message)
