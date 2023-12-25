@tool
extends Button


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	flat = true
	focus_mode = FOCUS_NONE
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
