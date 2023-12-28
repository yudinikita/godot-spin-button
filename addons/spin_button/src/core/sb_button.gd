## Base class for spin buttons.
@tool
@icon("res://addons/spin_button/assets/icons/sb_button.png")
class_name SBButton
extends SBBaseButton

## Visibility types for the control.
enum Visibility {
	## Never show the control. Used method [member hide].
	NEVER,
	## Always show the control. Used method [member show].
	ALWAYS,
	## Show the control only when the button is [b]clicked[/b].
	CLICK,
	## Show the control only when the button is [b]hovered[/b].
	HOVER,
	## Show the control only when the button is [b]focused[/b].
	FOCUS
}

# region Export Variables

## The button's text that will be displayed inside the title button's area.
@export_multiline var title: String = "":
	set = set_title,
	get = get_title

@export_group("Description")
## Description of the button.
@export_multiline var description: String = "":
	set = set_desc,
	get = get_desc

## Visibility of the description.
@export var description_visibility: Visibility = Visibility.NEVER:
	set = _set_description_visibility

@export_group("Left Icon")
## Left icon of the button.
@export var left_icon: Texture2D:
	set = _set_left_icon

## Visibility of the left icon.
@export var left_icon_visibility: Visibility = Visibility.NEVER:
	set = _set_left_icon_visibility

## Focus mode for left icon.
@export_enum("None", "Click", "All") var left_icon_focus_mode: int = Control.FOCUS_NONE:
	set = _set_left_icon_focus_mode

## Mouse filter for left icon.
@export_enum("Stop", "Pass", "Ignore") var left_icon_mouse_filter: int = Control.MOUSE_FILTER_PASS:
	set = _set_left_icon_mouse_filter

@export_group("Right Icon")
## Right icon of the button.
@export var right_icon: Texture2D:
	set = _set_right_icon

## Visibility of the right icon.
@export var right_icon_visibility: Visibility = Visibility.NEVER:
	set = _set_right_icon_visibility

## Focus mode for right icon.
@export_enum("None", "Click", "All") var right_icon_focus_mode: int = Control.FOCUS_NONE:
	set = _set_right_icon_focus_mode

## Mouse filter for right icon.
@export_enum("Stop", "Pass", "Ignore") var right_icon_mouse_filter: int = Control.MOUSE_FILTER_PASS:
	set = _set_right_icon_mouse_filter

@export_group("Title Behavior")
## Visibility of the title block.
@export var title_block_visibility: Visibility = Visibility.ALWAYS:
	set = _set_title_block_visibility

## Alignment of the title.
@export_enum("Left:0", "Center:4", "Right:8") var title_alignment: int = Control.SIZE_SHRINK_BEGIN:
	set = _set_title_alignment

## Mouse filter for title.
@export_enum("Stop", "Pass", "Ignore") var title_mouse_filter: int = Control.MOUSE_FILTER_PASS:
	set = _set_title_mouse_filter

## Stretch ratio of the title.
@export_range(0.0, 20.0, 0.01) var title_stretch_ratio: float = 1.0:
	set = _set_title_stretch_ratio

@export_group("Description Behavior")
## Alignment of the description.
@export_enum("Left:0", "Center:4", "Right:8")
var description_alignment: int = Control.SIZE_SHRINK_BEGIN:
	set = _set_description_alignment

@export_group("Content Behavior")
## Visibility of the content block.
@export var content_block_visibility: Visibility = Visibility.ALWAYS:
	set = _set_content_block_visibility

## Mouse filter for content.
@export_enum("Stop", "Pass", "Ignore") var content_mouse_filter: int = Control.MOUSE_FILTER_PASS:
	set = _set_content_mouse_filter

## Stretch ratio of the content.
@export_range(0.0, 20.0, 0.01) var content_stretch_ratio: float = 1.0:
	set = _set_content_stretch_ratio

## If [code]true[/code], the content button is flat.
@export var content_button_flat: bool = true:
	set = _set_content_button_flat

@export_group("Value Behavior")
## Focus mode for value.
@export_enum("None", "Click", "All") var value_focus_mode: int = Control.FOCUS_NONE:
	set = _set_value_focus_mode

## Mouse filter for value.
@export_enum("Stop", "Pass", "Ignore") var value_mouse_filter: int = Control.MOUSE_FILTER_IGNORE:
	set = _set_value_mouse_filter

## If [code]true[/code], the value button is flat.
@export var value_button_flat: bool = true:
	set = _set_value_button_flat

@export_group("Custom Themes")
## Theme for the title button.
@export var title_button_theme: Theme:
	set = _set_title_button_theme

## Theme for the content.
@export var content_theme: Theme:
	set = _set_content_theme

## Theme for the value.
@export var value_theme: Theme:
	set = _set_value_theme

## Theme for the left icon.
@export var left_icon_theme: Theme:
	set = _set_left_icon_theme

## Theme for the right icon.
@export var right_icon_theme: Theme:
	set = _set_right_icon_theme

# endregion


func _inner_init() -> void:
	_init_controls_properties()


func _inner_initialize() -> void:
	_update_all_visibilities()


# region Public methods


## Sets the title of the button.
func set_title(value: String) -> void:
	title = value
	title_label.text = value


## Gets the title of the button.
func get_title() -> String:
	return title


## Sets the description of the button.
func set_desc(value: String) -> void:
	description = value
	desc_label.text = value


## Gets the description of the button.
func get_desc() -> String:
	return description


# endregion

# region Setters & Getters


func _set_title_block_visibility(value: Visibility) -> void:
	title_block_visibility = value

	if _is_initialized:
		_update_visibility(title_wrapper, value)
		recalc_min_size()


func _set_content_block_visibility(value: Visibility) -> void:
	content_block_visibility = value

	if _is_initialized:
		_update_visibility(content_wrapper, value)
		recalc_min_size()


func _set_description_visibility(value: Visibility) -> void:
	description_visibility = value

	if _is_initialized:
		_update_visibility(desc_label, value)
		recalc_min_size()


func _set_title_mouse_filter(value: MouseFilter) -> void:
	title_mouse_filter = value
	title_button.mouse_filter = value


func _set_content_mouse_filter(value: MouseFilter) -> void:
	content_mouse_filter = value
	content_button.mouse_filter = value


func _set_title_stretch_ratio(value: float) -> void:
	title_stretch_ratio = value
	title_wrapper.size_flags_stretch_ratio = max(0.0, min(20.0, value))


func _set_content_stretch_ratio(value: float) -> void:
	content_stretch_ratio = value
	content_wrapper.size_flags_stretch_ratio = max(0.0, min(20.0, value))


func _set_content_button_flat(value: float) -> void:
	content_button_flat = value
	content_button.flat = value


func _set_value_focus_mode(value: FocusMode) -> void:
	value_focus_mode = value
	value_button.focus_mode = value


func _set_value_mouse_filter(value: MouseFilter) -> void:
	value_mouse_filter = value
	value_button.mouse_filter = value


func _set_value_button_flat(value: bool) -> void:
	value_button_flat = value
	value_button.flat = value


func _set_title_alignment(value: Control.SizeFlags) -> void:
	title_alignment = value
	title_label.size_flags_horizontal = value


func _set_description_alignment(value: Control.SizeFlags) -> void:
	description_alignment = value
	desc_label.size_flags_horizontal = value


func _set_title_button_theme(value: Theme) -> void:
	title_button_theme = value
	_update_button_theme(title_button, title_button_theme)


func _set_content_theme(value: Theme) -> void:
	content_theme = value
	_update_button_theme(content_button, content_theme)


func _set_value_theme(value: Theme) -> void:
	value_theme = value
	_update_button_theme(value_button, value)


func _set_left_icon_theme(value: Theme) -> void:
	left_icon_theme = value
	_update_button_theme(left_icon_button, left_icon_theme)


func _set_right_icon_theme(value: Theme) -> void:
	right_icon_theme = value
	_update_button_theme(right_icon_button, right_icon_theme)


func _set_left_icon(value: Texture2D) -> void:
	left_icon = value
	left_icon_button.icon = value


func _set_right_icon(value: Texture2D) -> void:
	right_icon = value
	right_icon_button.icon = value


func _set_left_icon_visibility(value: Visibility) -> void:
	left_icon_visibility = value

	if _is_initialized:
		_update_visibility(left_icon_button, value)


func _set_right_icon_visibility(value: Visibility) -> void:
	right_icon_visibility = value

	if _is_initialized:
		_update_visibility(right_icon_button, value)


func _set_left_icon_focus_mode(value: FocusMode) -> void:
	left_icon_focus_mode = value
	left_icon_button.focus_mode = value


func _set_left_icon_mouse_filter(value: MouseFilter) -> void:
	left_icon_mouse_filter = value
	left_icon_button.mouse_filter = value


func _set_right_icon_focus_mode(value: FocusMode) -> void:
	right_icon_focus_mode = value
	right_icon_button.focus_mode = value


func _set_right_icon_mouse_filter(value: MouseFilter) -> void:
	right_icon_mouse_filter = value
	right_icon_button.mouse_filter = value


# endregion

# region Private methods


func _custom_signals() -> void:
	focus_entered.connect(Callable(self, "_on_slider_focus_entered"))
	focus_exited.connect(Callable(self, "_on_slider_focus_exited"))
	mouse_entered.connect(Callable(self, "_on_slider_mouse_entered"))
	mouse_exited.connect(Callable(self, "_on_slider_mouse_exited"))
	title_container.minimum_size_changed.connect(Callable(self, "_on_recalc_min_size"))
	content_container.minimum_size_changed.connect(Callable(self, "_on_recalc_min_size"))


func _init_controls_properties() -> void:
	left_icon_button.focus_mode = left_icon_focus_mode
	left_icon_button.mouse_filter = left_icon_mouse_filter
	left_icon_button.theme = left_icon_theme

	right_icon_button.focus_mode = right_icon_focus_mode
	right_icon_button.mouse_filter = right_icon_mouse_filter
	right_icon_button.theme = right_icon_theme

	title_wrapper.size_flags_stretch_ratio = title_stretch_ratio
	title_button.mouse_filter = title_mouse_filter
	title_button.theme = title_button_theme
	title_label.size_flags_horizontal = title_alignment

	desc_label.size_flags_horizontal = description_alignment

	content_wrapper.size_flags_stretch_ratio = content_stretch_ratio
	content_button.mouse_filter = content_mouse_filter
	content_button.flat = content_button_flat
	content_button.theme = content_theme

	value_button.focus_mode = value_focus_mode
	value_button.mouse_filter = value_mouse_filter
	value_button.flat = value_button_flat


func _update_button_theme(btn: Button, btn_theme: Theme) -> void:
	if btn:
		btn.theme = btn_theme


func _update_visibility(control: Control, control_visibility: Visibility) -> void:
	match control_visibility:
		Visibility.NEVER:
			control.hide()
		Visibility.ALWAYS:
			control.show()
		Visibility.CLICK:
			control.hide()
		Visibility.FOCUS:
			if has_focus():
				control.show()
			else:
				control.hide()
		Visibility.HOVER:
			if is_hovered():
				control.show()
			else:
				control.hide()


func _update_all_visibilities() -> void:
	_update_visibility(left_icon_button, left_icon_visibility)
	_update_visibility(right_icon_button, right_icon_visibility)
	_update_visibility(title_wrapper, title_block_visibility)
	_update_visibility(desc_label, description_visibility)
	_update_visibility(content_wrapper, content_block_visibility)


func _update_visibility_hover(
	has_hovered: bool, control: Control, control_visibility: Visibility
) -> void:
	if control_visibility == Visibility.HOVER:
		control.visible = has_hovered


# endregion

# region Signals


func _on_recalc_min_size() -> void:
	recalc_min_size()


func _on_slider_focus_entered() -> void:
	_update_all_visibilities()


func _on_slider_focus_exited() -> void:
	_update_all_visibilities()


func _on_slider_mouse_entered() -> void:
	_update_visibility_hover(true, left_icon_button, left_icon_visibility)
	_update_visibility_hover(true, right_icon_button, right_icon_visibility)
	_update_visibility_hover(true, title_wrapper, title_block_visibility)
	_update_visibility_hover(true, desc_label, description_visibility)
	_update_visibility_hover(true, content_wrapper, content_block_visibility)


func _on_slider_mouse_exited() -> void:
	_update_visibility_hover(false, left_icon_button, left_icon_visibility)
	_update_visibility_hover(false, right_icon_button, right_icon_visibility)
	_update_visibility_hover(false, title_wrapper, title_block_visibility)
	_update_visibility_hover(false, desc_label, description_visibility)
	_update_visibility_hover(false, content_wrapper, content_block_visibility)

# endregion
