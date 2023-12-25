@tool
extends Button


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	flat = true
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	size_flags_vertical = Control.SIZE_SHRINK_CENTER
