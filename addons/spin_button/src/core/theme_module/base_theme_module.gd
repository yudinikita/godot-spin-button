@tool
extends RefCounted

enum ButtonState { INIT, NORMAL, DISABLED, HOVER, FOCUS, PRESSED }

# C - Control
const C_WRAPPER := "SBWrapper"
const C_TITLE := "SBTitle"
const C_DESCRIPTION := "SBDesc"
const C_VALUE := "SBValue"
const C_LEFT_ICON := "SBLeftIcon"
const C_RIGHT_ICON := "SBRightIcon"
const C_NEXT_NAV := "SBNextNav"
const C_PREV_NAV := "SBPrevNav"
const C_SLIDER := "SBSlider"
const C_SLIDER_VALUE := "SBSliderValue"
const C_SLIDER_TOOLTIP := "SBSliderTooltip"
const C_CONTENT := "SBContent"

const THEME_TYPES_LIST: PackedStringArray = [
	C_WRAPPER,
	C_TITLE,
	C_DESCRIPTION,
	C_VALUE,
	C_LEFT_ICON,
	C_RIGHT_ICON,
	C_NEXT_NAV,
	C_PREV_NAV,
	C_SLIDER,
	C_SLIDER_VALUE,
	C_SLIDER_TOOLTIP,
	C_CONTENT
]

# region Properties

const P_DEFAULT_COLOR := "default_color"
const P_FONT_OUTLINE_COLOR := "font_outline_color"
const P_FONT_SHADOW_COLOR := "font_shadow_color"
const P_FONT_DISABLED_COLOR := "font_disabled_color"
const P_FONT_FOCUS_COLOR := "font_focus_color"
const P_FONT_HOVER_COLOR := "font_hover_color"
const P_FONT_PRESSED_COLOR := "font_pressed_color"

const P_ICON_NORMAL_COLOR := "icon_normal_color"
const P_ICON_DISABLED_COLOR := "icon_disabled_color"
const P_ICON_FOCUS_COLOR := "icon_focus_color"
const P_ICON_HOVER_COLOR := "icon_hover_color"
const P_ICON_PRESSED_COLOR := "icon_pressed_color"

const P_NORMAL_FONT_SIZE := "normal_font_size"
const P_BOLD_FONT_SIZE := "bold_font_size"
const P_BOLD_ITALICS_FONT_SIZE := "bold_italics_font_size"
const P_ITALICS_FONT_SIZE := "italics_font_size"
const P_MONO_FONT_SIZE := "mono_font_size"

const P_NORMAL_FONT := "normal_font"
const P_MONO_FONT := "mono_font"
const P_ITALICS_FONT := "italics_font"
const P_BOLD_ITALICS_FONT := "bold_italics_font"
const P_BOLD_FONT := "bold_font"

const P_LINE_SEPARATION := "line_separation"
const P_OUTLINE_SIZE := "outline_size"
const P_SHADOW_OFFSET_X := "shadow_offset_x"
const P_SHADOW_OFFSET_Y := "shadow_offset_y"
const P_SHADOW_OUTLINE_SIZE := "shadow_outline_size"

const P_NORMAL := "normal"
const P_DISABLED := "disabled"
const P_FOCUS := "focus"
const P_HOVER := "hover"
const P_PRESSED := "pressed"

const P_MARGIN_BOTTOM := "margin_bottom"
const P_MARGIN_LEFT := "margin_left"
const P_MARGIN_RIGHT := "margin_right"
const P_MARGIN_TOP := "margin_top"

const P_GRABBER := "grabber"
const P_GRABBER_DISABLED := "grabber_disabled"
const P_GRABBER_FOCUS := "grabber_focus"
const P_GRABBER_HOVER := "grabber_hover"
const P_GRABBER_PRESSED := "grabber_pressed"

const P_GRABBER_AREA := "grabber_area"
const P_GRABBER_AREA_DISABLED := "grabber_area_disabled"
const P_GRABBER_AREA_FOCUS := "grabber_area_focus"
const P_GRABBER_AREA_HOVER := "grabber_area_hover"
const P_GRABBER_AREA_PRESSED := "grabber_area_pressed"

const P_SLIDER := "slider"
const P_SLIDER_DISABLED := "slider_disabled"
const P_SLIDER_FOCUS := "slider_focus"
const P_SLIDER_HOVER := "slider_hover"
const P_SLIDER_PRESSED := "slider_pressed"

const P_ICON_MAX_WIDTH := "icon_max_width"

const P_CENTER_GRABBER := "center_grabber"
const P_GRABBER_OFFSET := "grabber_offset"

# endregion

var _theme: Theme:
	get = get_theme

var _owner: SBBaseButton
var _controls: Dictionary = {}
var _valid_theme_types: PackedStringArray = []


func get_theme() -> Theme:
	return _owner.get_theme()


func _initialize_valid_theme_types() -> void:
	if not _theme:
		return

	var theme_types = _theme.get_type_list()

	if not theme_types:
		return

	for type_name in theme_types:
		if THEME_TYPES_LIST.has(type_name):
			_valid_theme_types.append(type_name)


func _initialize_controls() -> void:
	_controls = {
		C_WRAPPER: _owner.wrapper,
		C_TITLE: _owner.title_label,
		C_DESCRIPTION: _owner.desc_label,
		C_VALUE: _owner.value_text_label,
		C_LEFT_ICON: _owner.left_icon_button,
		C_RIGHT_ICON: _owner.right_icon_button,
		C_NEXT_NAV: _owner.next_button,
		C_PREV_NAV: _owner.prev_button,
		C_SLIDER: _owner.slider,
		C_SLIDER_VALUE: _owner.slider_value,
		C_SLIDER_TOOLTIP: _owner.slider_value_tooltip,
		C_CONTENT: _owner.content_button
	}


func _add_color(
	control_name: String, property_name: String, property_override: String = ""
) -> bool:
	if not _theme.has_color(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_color(property_name, control_name)
	control.add_theme_color_override(property_override, theme_value)
	return true


func _add_constant(
	control_name: String, property_name: String, property_override: String = ""
) -> bool:
	if not _theme.has_constant(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_constant(property_name, control_name)
	control.add_theme_constant_override(property_override, theme_value)
	return true


func _add_font(control_name: String, property_name: String, property_override: String = "") -> bool:
	if not _theme.has_font(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_font(property_name, control_name)
	control.add_theme_font_override(property_override, theme_value)
	return true


func _add_font_size(
	control_name: String, property_name: String, property_override: String = ""
) -> bool:
	if not _theme.has_font_size(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_font_size(property_name, control_name)
	control.add_theme_font_size_override(property_override, theme_value)
	return true


func _add_icon(control_name: String, property_name: String, property_override: String = "") -> bool:
	if not _theme.has_icon(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_icon(property_name, control_name)
	control.add_theme_icon_override(property_override, theme_value)
	return true


func _add_stylebox(
	control_name: String, property_name: String, property_override: String = ""
) -> bool:
	if not _theme.has_stylebox(property_name, control_name):
		return false

	if property_override == "":
		property_override = property_name
	var control: Control = _get_control(control_name)
	var theme_value = _theme.get_stylebox(property_name, control_name)
	control.add_theme_stylebox_override(property_override, theme_value)
	return true


func _get_control(control_name: String) -> Variant:
	return _controls.get(control_name)


func _remove_theme_margin_container(control_name: String) -> void:
	var control: Control = _get_control(control_name)
	var margin_sizes := [P_MARGIN_BOTTOM, P_MARGIN_LEFT, P_MARGIN_RIGHT, P_MARGIN_TOP]
	for margin_size in margin_sizes:
		control.remove_theme_constant_override(margin_size)


func _remove_theme_label(control_name: String) -> void:
	var control: Control = _get_control(control_name)
	var colors := [P_DEFAULT_COLOR, P_FONT_OUTLINE_COLOR, P_FONT_SHADOW_COLOR]
	for color in colors:
		control.remove_theme_color_override(color)
	var constants := [
		P_LINE_SEPARATION,
		P_OUTLINE_SIZE,
		P_SHADOW_OFFSET_X,
		P_SHADOW_OFFSET_Y,
		P_SHADOW_OUTLINE_SIZE
	]
	for constant in constants:
		control.remove_theme_constant_override(constant)
	var fonts := [P_NORMAL_FONT, P_MONO_FONT, P_ITALICS_FONT, P_BOLD_ITALICS_FONT, P_BOLD_FONT]
	for font in fonts:
		control.remove_theme_font_override(font)
	control.remove_theme_font_size_override(P_NORMAL_FONT_SIZE)
	control.remove_theme_stylebox_override(P_NORMAL)


func _remove_theme_button(control_name: String) -> void:
	var control: Control = _get_control(control_name)
	control.remove_theme_color_override(P_ICON_NORMAL_COLOR)
	control.remove_theme_constant_override(P_ICON_MAX_WIDTH)
	control.remove_theme_stylebox_override(P_NORMAL)


func _remove_theme_slider(control_name: String) -> void:
	var control: Control = _get_control(control_name)
	control.remove_theme_icon_override(P_GRABBER)
	control.remove_theme_stylebox_override(P_GRABBER_AREA)
	control.remove_theme_stylebox_override(P_SLIDER)


func _apply_init_label(control_name: String) -> void:
	var colors := [P_DEFAULT_COLOR, P_FONT_OUTLINE_COLOR, P_FONT_SHADOW_COLOR]
	for color in colors:
		_add_color(control_name, color)
	var constants := [
		P_LINE_SEPARATION,
		P_OUTLINE_SIZE,
		P_SHADOW_OFFSET_X,
		P_SHADOW_OFFSET_Y,
		P_SHADOW_OUTLINE_SIZE
	]
	for constant in constants:
		_add_constant(control_name, constant)
	var fonts := [P_NORMAL_FONT, P_MONO_FONT, P_ITALICS_FONT, P_BOLD_ITALICS_FONT, P_BOLD_FONT]
	for font in fonts:
		_add_font(control_name, font)
	var font_sizes := [
		P_NORMAL_FONT_SIZE,
		P_BOLD_FONT_SIZE,
		P_BOLD_ITALICS_FONT_SIZE,
		P_ITALICS_FONT_SIZE,
		P_MONO_FONT_SIZE
	]
	for font_size in font_sizes:
		_add_font_size(control_name, font_size)


func _apply_init_button(control_name: String) -> void:
	_add_color(control_name, P_ICON_DISABLED_COLOR)
	_add_constant(control_name, P_ICON_MAX_WIDTH)
	_add_stylebox(control_name, P_DISABLED)


func _apply_init_margin_container(control_name: String) -> void:
	var margin_sizes := [P_MARGIN_BOTTOM, P_MARGIN_LEFT, P_MARGIN_RIGHT, P_MARGIN_TOP]
	for margin_size in margin_sizes:
		_add_constant(control_name, margin_size)


func _apply_init_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER)
	_add_constant(control_name, P_CENTER_GRABBER)
	_add_constant(control_name, P_GRABBER_OFFSET)


func _apply_normal_label(control_name: String) -> void:
	_add_color(control_name, P_DEFAULT_COLOR)
	_add_stylebox(control_name, P_NORMAL)


func _apply_normal_button(control_name: String) -> void:
	_add_color(control_name, P_ICON_NORMAL_COLOR)
	_add_constant(control_name, P_ICON_MAX_WIDTH)
	_add_stylebox(control_name, P_NORMAL)


func _apply_normal_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER)


func _apply_disabled_label(control_name: String) -> void:
	_add_color(control_name, P_FONT_DISABLED_COLOR, P_DEFAULT_COLOR)
	_add_stylebox(control_name, P_DISABLED, P_NORMAL)


func _apply_disabled_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER_DISABLED, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA_DISABLED, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER_DISABLED, P_SLIDER)


func _apply_hover_label(control_name: String) -> void:
	_add_color(control_name, P_FONT_HOVER_COLOR, P_DEFAULT_COLOR)
	_add_stylebox(control_name, P_HOVER, P_NORMAL)


func _apply_hover_button(control_name: String) -> void:
	_add_color(control_name, P_ICON_HOVER_COLOR, P_ICON_NORMAL_COLOR)
	_add_stylebox(control_name, P_HOVER, P_NORMAL)


func _apply_hover_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER_HOVER, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA_HOVER, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER_HOVER, P_SLIDER)


func _apply_focus_label(control_name: String) -> void:
	_add_color(control_name, P_FONT_FOCUS_COLOR, P_DEFAULT_COLOR)
	_add_stylebox(control_name, P_FOCUS, P_NORMAL)


func _apply_focus_button(control_name: String) -> void:
	_add_color(control_name, P_ICON_FOCUS_COLOR, P_ICON_NORMAL_COLOR)
	_add_stylebox(control_name, P_FOCUS, P_NORMAL)


func _apply_focus_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER_FOCUS, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA_FOCUS, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER_FOCUS, P_SLIDER)


func _apply_pressed_label(control_name: String) -> void:
	_add_color(control_name, P_FONT_PRESSED_COLOR, P_DEFAULT_COLOR)
	_add_stylebox(control_name, P_PRESSED, P_NORMAL)


func _apply_pressed_button(control_name: String) -> void:
	_add_color(control_name, P_ICON_PRESSED_COLOR, P_ICON_NORMAL_COLOR)
	_add_stylebox(control_name, P_PRESSED, P_NORMAL)


func _apply_pressed_slider(control_name: String) -> void:
	_add_icon(control_name, P_GRABBER_PRESSED, P_GRABBER)
	_add_stylebox(control_name, P_GRABBER_AREA_PRESSED, P_GRABBER_AREA)
	_add_stylebox(control_name, P_SLIDER_PRESSED, P_SLIDER)
