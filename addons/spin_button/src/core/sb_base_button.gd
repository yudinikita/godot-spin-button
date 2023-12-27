## SBBaseButton is an abstract base class for GUI SBButtons. Can be used to create custom buttons.
@tool
@icon("res://addons/spin_button/assets/icons/sb_base.png")
class_name SBBaseButton
extends Button

# region Signals

## Emitted when a button is disabled.
signal button_disabled

## Emitted when a button is enabled.
signal button_enabled

## Emitted right after button initialization.
signal button_initialized

## Emitted when the next button is pressed.
signal next_pressed

## Emitted when the prev button is pressed.
signal prev_pressed

## Emitted when a value button is pressed.
signal value_pressed

## Emitted when a left icon button is pressed.
signal left_icon_pressed

## Emitted when a right icon button is pressed.
signal right_icon_pressed

## Emitted when the content button is pressed.
signal content_pressed

#endregion

# region Constants

const WRAPPER_NAME := "Wrapper"
const CONTAINER_NAME := "Container"
const LEFT_ICON_NAME := "LeftIcon"
const RIGHT_ICON_NAME := "RightIcon"
const TITLE_WRAPPER_NAME := "TitleWrapper"
const TITLE_NAME := "TitleButton"
const TITLE_CONTAINER_NAME := "TitleContainer"
const TITLE_LABEL_NAME := "TitleLabel"
const DESC_LABEL_NAME := "DescriptionLabel"
const CONTENT_WRAPPER_NAME := "ContentWrapper"
const CONTENT_BUTTON_NAME := "ContentButton"
const CONTENT_NAME := "ContentContainer"
const PREV_WRAPPER_NAME := "PrevWrapper"
const PREV_NAME := "PrevButton"
const NEXT_WRAPPER_NAME := "NextWrapper"
const NEXT_NAME := "NextButton"
const VALUE_WRAPPER_NAME := "ValueWrapper"
const VALUE_NAME := "ValueButton"
const VALUE_TEXT_NAME := "ValueText"
const VALUE_TEXT_CONTAINER_NAME := "ValueTextContainer"
const SLIDER_WRAPPER_NAME := "SliderWrapper"
const H_SLIDER_CONTAINER_NAME := "HSliderContainer"
const V_SLIDER_CONTAINER_NAME := "VSliderContainer"
const SLIDER_NAME := "Slider"
const SLIDER_VALUE_NAME := "SliderValue"
const SLIDER_VALUE_TOOLTIP_NAME := "SliderValueTooltip"
const OPTION_NAME := "OptionButton"

const DEFAULT_MARGIN := 4

# endregion

# region Properties

## Whether [b]SpinButton[/b] should be initialised automatically when you create an instance.
## If disabled, then you need to auto_initialize it manually by calling [method initialize].
## Note that the [method _init] will work in any case.
@export var auto_initialize: bool = true

## Whether the minimum button height should be auto calculated
## based on the title and content height.
@export var auto_min_height: bool = true:
	set = _set_auto_min_height

@export_group("Expand Value")
## Whether the value should expand to fill the available space.
@export var expand_value: bool = true:
	set = _set_expand_value

## The minimum size for the value when [member expand_value] is [code]false[/code].
@export var expand_value_min_size: Vector2 = Vector2.ZERO:
	set = _set_expand_value_min_size

## Main wrapper container. Used for set the margins.
var wrapper: SBComponents.WrapperContainer

## Main container for UI elements. Used to set the alignment.
var container: HBoxContainer

## Wrapper container for the title section.
var title_wrapper: SBComponents.WrapperContainer

## Container for the title section.
var title_container: VBoxContainer

## Wrapper container for the content section.
var content_wrapper: SBComponents.WrapperContainer

## Container for the content section.
var content_container: HBoxContainer

## Wrapper container for the previous button.
var prev_wrapper: SBComponents.WrapperContainer

## Wrapper container for the value section.
var value_wrapper: SBComponents.WrapperContainer

## Wrapper container for the slider section.
var slider_wrapper: SBComponents.WrapperContainer

## Horizontal container for the slider section.
var slider_container_h: HBoxContainer

## Vertical container for the slider section.
var slider_container_v: VBoxContainer

## Wrapper container for the next button.
var next_wrapper: SBComponents.WrapperContainer

## Container for the value text section.
var value_text_container: MarginContainer

## Icon button for left navigation.
var left_icon_button: SBComponents.IconButton

## Icon button for right navigation.
var right_icon_button: SBComponents.IconButton

## Button for the title section.
var title_button: SBComponents.TitleButton

## Label for the title section.
var title_label: SBComponents.RichLabel

## Label for the description section.
var desc_label: SBComponents.RichLabel

## Button for the content section.
var content_button: SBComponents.ContentButton

## Button for the next navigation.
var next_button: SBComponents.NavButton

## Button for the previous navigation.
var prev_button: SBComponents.NavButton

## Button for the value section.
var value_button: SBComponents.ValueButton

## Label for the value text section.
var value_text_label: SBComponents.RichLabel

## Slider for the slider section.
var slider: SBComponents.SliderSpin

## Label for the slider value.
var slider_value: SBComponents.RichLabel

## Label for the slider value tooltip.
var slider_value_tooltip: SBComponents.RichLabel

## Module for theme related functionality.
var theme_module: SBModules.ThemeModule

var _is_initialized: bool

# endregion

# region Built-in


func _set(property, value):
	if property == "disabled":
		_set_property_disabled(value)
	if property == "theme":
		_set_property_theme(value)


func _init() -> void:
	_init_controls()
	_hide_controls()
	_inner_init()
	_custom_init()


func _ready() -> void:
	if auto_initialize:
		initialize()


func _input(event: InputEvent) -> void:
	if not _is_initialized:
		return

	_custom_input(event)


# endregion

# region Public Methods


## Initializes the [b]SBButton[/b].
func initialize() -> void:
	# for fix duplicate in the editor
	if _has_children():
		_clear_children()

	if _can_init():
		_add_controls()
		_update_expand_value()
		_initialize_theme_module()
		_connect_signals()
		_inner_initialize()
		_custom_signals()
		_custom_initialize()
		_is_initialized = true
		emit_signal("button_initialized")


## Checks if the [b]SBButton[/b] is initialized.
func is_initialized() -> bool:
	return _is_initialized


## Recalculates the minimum size.
func recalc_min_size() -> void:
	if auto_min_height:
		custom_minimum_size.y = max(
			title_container.size.y, content_container.size.y, value_text_container.size.y
		)
		custom_minimum_size.y += wrapper.get_theme_constant("margin_top")
		custom_minimum_size.y += wrapper.get_theme_constant("margin_bottom")


# endregion

# region Private Methods


func _inner_init() -> void:
	pass


func _inner_initialize() -> void:
	pass


func _custom_init() -> void:
	pass


func _custom_initialize() -> void:
	pass


func _custom_signals() -> void:
	pass


func _custom_input(_event: InputEvent) -> void:
	pass


func _can_init() -> bool:
	return not _is_initialized and get_child_count() == 0


func _has_children() -> bool:
	return not _is_initialized and get_child_count() > 0


func _clear_children() -> void:
	for child in get_children():
		child.free()


func _set_auto_min_height(value: bool) -> void:
	auto_min_height = value

	if _is_initialized:
		recalc_min_size()


func _set_expand_value(value: bool) -> void:
	expand_value = value

	if _is_initialized:
		_update_expand_value()


func _set_expand_value_min_size(value: Vector2) -> void:
	expand_value_min_size = value

	if _is_initialized:
		_update_expand_value()


func _set_property_disabled(value: bool) -> void:
	if value:
		emit_signal("button_disabled")
	else:
		emit_signal("button_enabled")
	disabled = value


func _set_property_theme(value: Theme) -> void:
	if value:
		_connect_theme_changed()
		theme = value
		if theme_module:
			theme_module.apply_theme()
	else:
		_disconnect_theme_changed()
		if theme_module:
			theme_module.reset_theme()
		theme = value


func _connect_signals() -> void:
	button_disabled.connect(Callable(self, "_on_button_disabled"))
	button_enabled.connect(Callable(self, "_on_button_disabled"))
	next_button.pressed.connect(Callable(self, "_on_next_pressed"))
	prev_button.pressed.connect(Callable(self, "_on_prev_pressed"))
	value_button.pressed.connect(Callable(self, "_on_value_pressed"))
	content_button.pressed.connect(Callable(self, "_on_content_pressed"))
	left_icon_button.pressed.connect(Callable(self, "_on_left_icon_pressed"))
	right_icon_button.pressed.connect(Callable(self, "_on_right_icon_pressed"))


func _connect_theme_changed() -> void:
	var theme_callable = Callable(self, "_on_theme_changed")
	if not theme_changed.is_connected(theme_callable):
		theme_changed.connect(theme_callable)


func _disconnect_theme_changed() -> void:
	var theme_callable = Callable(self, "_on_theme_changed")
	if theme_changed.is_connected(theme_callable):
		theme_changed.disconnect(theme_callable)


func _init_controls() -> void:
	_init_wrapper()
	_init_container()

	_init_left_icon_button()
	_init_title_wrapper()
	_init_content_wrapper()
	_init_right_icon_button()

	_init_title_button()
	_init_title_container()
	_init_title_label()
	_init_desc_label()

	_init_content_button()
	_init_content_container()

	_init_prev_wrapper()
	_init_value_wrapper()
	_init_slider_wrapper()
	_init_slider_container()
	_init_next_wrapper()

	_init_prev_button()
	_init_next_button()

	_init_value_button()
	_init_value_text_container()
	_init_value_text_label()

	_init_slider()
	_init_slider_value()
	_init_slider_value_tooltip()


func _add_controls() -> void:
	add_child(wrapper)
	wrapper.add_child(container)

	container.add_child(left_icon_button)
	container.add_child(title_wrapper)
	container.add_child(content_wrapper)
	container.add_child(right_icon_button)

	title_wrapper.add_child(title_button)
	title_button.add_child(title_container)
	title_container.add_child(title_label)
	title_container.add_child(desc_label)

	content_wrapper.add_child(content_button)
	content_button.add_child(content_container)
	content_container.add_child(prev_wrapper)
	content_container.add_child(value_wrapper)
	content_container.add_child(next_wrapper)

	prev_wrapper.add_child(prev_button)
	next_wrapper.add_child(next_button)

	value_wrapper.add_child(value_button)
	value_button.add_child(value_text_container)
	value_button.add_child(slider_wrapper)
	value_text_container.add_child(value_text_label)

	slider_wrapper.add_child(slider_container_v)
	slider_wrapper.add_child(slider_container_h)
	slider_container_h.add_child(slider)
	slider_container_h.add_child(slider_value)
	slider.add_child(slider_value_tooltip)


func _hide_controls() -> void:
	left_icon_button.hide()
	right_icon_button.hide()

	prev_button.hide()
	value_button.hide()
	next_button.hide()

	desc_label.hide()

	value_text_container.hide()
	slider_value.hide()
	slider_value_tooltip.hide()
	slider_wrapper.hide()


func _update_expand_value() -> void:
	if expand_value:
		value_wrapper.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		content_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	else:
		value_wrapper.size_flags_horizontal = Control.SIZE_FILL
		content_button.size_flags_horizontal = Control.SIZE_FILL
		value_wrapper.custom_minimum_size = expand_value_min_size
		value_button.custom_minimum_size = value_text_label.get_minimum_size()


# endregion

# region Init methods


func _initialize_theme_module() -> void:
	theme_module = SBModules.ThemeModule.new()
	theme_module.initialize(self)
	_connect_theme_changed()


func _init_wrapper() -> void:
	wrapper = SBComponents.WrapperContainer.new()
	wrapper.name = WRAPPER_NAME
	wrapper.set_anchors_preset(PRESET_FULL_RECT)
	wrapper.add_theme_constant_override("margin_top", DEFAULT_MARGIN)
	wrapper.add_theme_constant_override("margin_left", DEFAULT_MARGIN)
	wrapper.add_theme_constant_override("margin_bottom", DEFAULT_MARGIN)
	wrapper.add_theme_constant_override("margin_right", DEFAULT_MARGIN)


func _init_container() -> void:
	container = HBoxContainer.new()
	container.name = CONTAINER_NAME


func _init_title_wrapper() -> void:
	title_wrapper = SBComponents.WrapperContainer.new()
	title_wrapper.name = TITLE_WRAPPER_NAME
	title_wrapper.size_flags_horizontal = SIZE_EXPAND_FILL


func _init_title_container() -> void:
	title_container = VBoxContainer.new()
	title_container.name = TITLE_CONTAINER_NAME
	title_container.alignment = BoxContainer.ALIGNMENT_CENTER
	title_container.set_anchors_preset(PRESET_FULL_RECT)


func _init_content_wrapper() -> void:
	content_wrapper = SBComponents.WrapperContainer.new()
	content_wrapper.name = CONTENT_WRAPPER_NAME
	content_wrapper.size_flags_horizontal = SIZE_EXPAND_FILL


func _init_content_container() -> void:
	content_container = HBoxContainer.new()
	content_container.name = CONTENT_NAME
	content_container.alignment = BoxContainer.ALIGNMENT_END
	content_container.set_anchors_preset(PRESET_FULL_RECT)


func _init_prev_wrapper() -> void:
	prev_wrapper = SBComponents.WrapperContainer.new()
	prev_wrapper.name = PREV_WRAPPER_NAME


func _init_value_wrapper() -> void:
	value_wrapper = SBComponents.WrapperContainer.new()
	value_wrapper.name = VALUE_WRAPPER_NAME
	value_wrapper.set_anchors_preset(PRESET_FULL_RECT)


func _init_slider_wrapper() -> void:
	slider_wrapper = SBComponents.WrapperContainer.new()
	slider_wrapper.name = SLIDER_WRAPPER_NAME
	slider_wrapper.set_anchors_preset(PRESET_FULL_RECT)


func _init_slider_container() -> void:
	slider_container_h = HBoxContainer.new()
	slider_container_h.name = H_SLIDER_CONTAINER_NAME

	slider_container_v = VBoxContainer.new()
	slider_container_v.name = V_SLIDER_CONTAINER_NAME


func _init_value_text_container() -> void:
	value_text_container = SBComponents.WrapperContainer.new()
	value_text_container.name = VALUE_TEXT_CONTAINER_NAME
	value_text_container.set_anchors_preset(PRESET_FULL_RECT)


func _init_next_wrapper() -> void:
	next_wrapper = SBComponents.WrapperContainer.new()
	next_wrapper.name = NEXT_WRAPPER_NAME


func _init_content_button() -> void:
	content_button = SBComponents.ContentButton.new()
	content_button.name = CONTENT_BUTTON_NAME
	content_button.size_flags_horizontal = SIZE_EXPAND_FILL


func _init_left_icon_button() -> void:
	left_icon_button = SBComponents.IconButton.new()
	left_icon_button.name = LEFT_ICON_NAME
	left_icon_button.disabled = disabled


func _init_right_icon_button() -> void:
	right_icon_button = SBComponents.IconButton.new()
	right_icon_button.name = RIGHT_ICON_NAME
	right_icon_button.disabled = disabled


func _init_title_button() -> void:
	title_button = SBComponents.TitleButton.new()
	title_button.name = TITLE_NAME
	title_button.disabled = disabled


func _init_title_label() -> void:
	title_label = SBComponents.RichLabel.new()
	title_label.name = TITLE_LABEL_NAME


func _init_desc_label() -> void:
	desc_label = SBComponents.RichLabel.new()
	desc_label.name = DESC_LABEL_NAME


func _init_prev_button() -> void:
	prev_button = SBComponents.NavButton.new()
	prev_button.name = PREV_NAME
	prev_button.disabled = disabled


func _init_next_button() -> void:
	next_button = SBComponents.NavButton.new()
	next_button.disabled = disabled


func _init_value_button() -> void:
	value_button = SBComponents.ValueButton.new()
	value_button.name = VALUE_NAME
	value_button.disabled = disabled


func _init_value_text_label() -> void:
	value_text_label = SBComponents.RichLabel.new()
	value_text_label.name = VALUE_TEXT_NAME
	value_text_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	value_text_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER


func _init_slider() -> void:
	slider = SBComponents.SliderSpin.new()
	slider.name = SLIDER_NAME
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.size_flags_vertical = Control.SIZE_EXPAND_FILL


func _init_slider_value() -> void:
	slider_value = SBComponents.RichLabel.new()
	slider_value.name = SLIDER_VALUE_NAME
	slider_value.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	slider_value.size_flags_vertical = Control.SIZE_SHRINK_CENTER


func _init_slider_value_tooltip() -> void:
	slider_value_tooltip = SBComponents.RichLabel.new()
	slider_value_tooltip.name = SLIDER_VALUE_TOOLTIP_NAME


# endregion

# region Signals


func _on_next_pressed() -> void:
	emit_signal("next_pressed")


func _on_prev_pressed() -> void:
	emit_signal("prev_pressed")


func _on_value_pressed() -> void:
	emit_signal("value_pressed")


func _on_content_pressed() -> void:
	emit_signal("content_pressed")


func _on_left_icon_pressed() -> void:
	emit_signal("left_icon_pressed")


func _on_right_icon_pressed() -> void:
	emit_signal("right_icon_pressed")


func _on_button_disabled() -> void:
	title_button.disabled = disabled
	left_icon_button.disabled = disabled
	right_icon_button.disabled = disabled
	prev_button.disabled = disabled
	next_button.disabled = disabled
	value_button.disabled = disabled


func _on_theme_changed() -> void:
	if theme_module:
		theme_module.apply_theme()
		recalc_min_size()

# endregion
