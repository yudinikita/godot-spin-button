@tool
extends RichTextLabel


func _init() -> void:
	_init_properties()


func _init_properties() -> void:
	bbcode_enabled = true
	fit_content = true
	scroll_active = false
	autowrap_mode = TextServer.AUTOWRAP_OFF
	shortcut_keys_enabled = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
