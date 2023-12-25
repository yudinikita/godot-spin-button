@tool
extends Button


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	flat = true
	focus_mode = Control.FOCUS_CLICK
	mouse_filter = Control.MOUSE_FILTER_STOP
	size_flags_vertical = Control.SIZE_SHRINK_CENTER
	size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
