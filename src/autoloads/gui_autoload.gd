# Autoload class used to globally expose and handle GUI elements.

extends Node

@onready var message_box: MessageBox = get_tree().get_first_node_in_group("gui_message_box")
@onready var notification_box: NotificationBox = get_tree().get_first_node_in_group("gui_notification_box")
