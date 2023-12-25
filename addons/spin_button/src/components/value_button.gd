@tool
extends OptionButton

const SHOW_MODULATE_ARROW := 0
const HIDE_MODULATE_ARROW := 1
const TRANSPARENT_COLOR: Color = Color(0, 0, 0, 0)

var is_show_popup: bool:
	set = _set_is_show_popup


func _init() -> void:
	_init_properties()
	_hide_text()
	_connect_signals()
	_update_icon_arrow()


func _init_properties() -> void:
	flat = true
	clip_contents = true
	focus_mode = FOCUS_NONE
	mouse_filter = Control.MOUSE_FILTER_PASS
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
	allow_reselect = true
	fit_to_longest_item = false


func _hide_text() -> void:
	add_theme_color_override("font_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_pressed_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_hover_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_hover_pressed_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_focus_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_disabled_color", TRANSPARENT_COLOR)
	add_theme_color_override("font_outline_color", TRANSPARENT_COLOR)


func _connect_signals() -> void:
	get_popup().visibility_changed.connect(Callable(self, "_on_visibility_changed"))


func _set_is_show_popup(value: bool) -> void:
	is_show_popup = value
	_update_icon_arrow()


func _update_icon_arrow() -> void:
	if is_show_popup:
		add_theme_constant_override("modulate_arrow", SHOW_MODULATE_ARROW)
	else:
		add_theme_constant_override("modulate_arrow", HIDE_MODULATE_ARROW)


func _on_visibility_changed() -> void:
	if not is_show_popup:
		get_popup().hide()
