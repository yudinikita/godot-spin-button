@tool
extends Button


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	flat = true
	clip_contents = true
	focus_mode = FOCUS_NONE
	mouse_filter = MOUSE_FILTER_PASS
	text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
