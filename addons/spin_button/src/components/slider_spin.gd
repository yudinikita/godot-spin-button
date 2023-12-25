@tool
extends HSlider


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	focus_mode = Control.FOCUS_CLICK
	size_flags_vertical = Control.SIZE_EXPAND_FILL
