## A button with a horizontal slider.
## Used to adjust a value by moving a grabber along a horizontal axis.
@tool
@icon("res://addons/spin_button/assets/icons/sb_slider.png")
class_name SBSliderButton
extends SBButton

## Emitted when the value changed.
signal value_changed(value: float)

## Emitted when the value edges are reached.
signal edged(start: bool, end: bool)

## The placement of the value label.
enum ValuePlacement { LEFT, RIGHT, TOP, BOTTOM, CENTER }

# region Properties

## If [code]true[/code], the slider can be interacted with.
## If [code]false[/code], the value can be changed only by code.
@export var editable: bool = true:
	set = _set_editable

## If [code]true[/code], the value can be changed using the mouse wheel.
@export var scrollable: bool = true:
	set = _set_scrollable

## Number of ticks displayed on the slider, including border ticks.
## Ticks are uniformly-distributed value markers.
@export_range(0, 4096) var tick_count: int = 0:
	set = _set_tick_count

## If [code]true[/code], the slider will display ticks for minimum and maximum values.
@export var ticks_on_borders: bool:
	set = _set_ticks_on_borders

@export_group("Range")
## Minimum value. Range is clamped if [member value] is less than [member min_value].
@export var min_value: float = 0:
	set = _set_min_value

## Maximum value. Range is clamped if [member value] is greater than [member max_value].
@export var max_value: float = 100:
	set = _set_max_value

## If greater than 0, [member value] will always be rounded to a multiple of this property's value.
## If [member rounded] is also [code]true[/code],
## [member value] will first be rounded to a multiple of this property's value,
## then rounded to the nearest integer.
@export var step: float = 1:
	set = _set_step

## Page size. ScrollBar's length is its size multiplied
## by page over the difference between min_value and max_value.
@export_range(0, 100) var page: float = 0:
	set = _set_page

## Range's current value.
@export var value: float = 0:
	set = _set_value

## If [code]true[/code], and [member min_value] is greater than 0,
## [member value] will be represented exponentially rather than linearly.
@export var exp_edit: bool:
	set = _set_exp_edit

## If [code]true[/code], [member value] will always be rounded to the nearest integer.
@export var rounded: bool:
	set = _set_rounded

## If [code]true[/code], [member value] may be [b]greater[/b] than [member max_value].
@export var allow_greater: bool:
	set = _set_allow_greater

## If [code]true[/code], [member value] may be [b]less[/b] than [member min_value].
@export var allow_lesser: bool:
	set = _set_allow_lesser

@export_group("Value Label")
## Visibility of the value label.
@export var value_label_visibility: Visibility = Visibility.NEVER:
	set = _set_value_label_visibility

## Placement of the value label.
@export var value_label_placement: ValuePlacement = ValuePlacement.RIGHT:
	set = _set_value_label_placement

## Separation for the value.
@export var value_separation: int = 0:
	set = _set_value_separation

## Specifies the custom format for the value display.
## Requires exactly one placeholder (%s/%d/%f).
## You can also use it to display suffixes etc. Leave empty for no formatting.
@export var value_label_custom_format: String = "":
	set = _set_value_label_custom_format

@export_group("Value Tooltip")
## Visibility of the value tooltip.
@export var value_tooltip_visibility: Visibility = Visibility.NEVER:
	set = _set_value_tooltip_visibility

## Placement of the value tooltip.
@export var value_tooltip_placement: ValuePlacement = ValuePlacement.TOP:
	set = _set_value_tooltip_placement

## Separation for the value tooltip.
@export var value_tooltip_separation: int = 4:
	set = _set_value_tooltip_separation

## Specifies the custom format for the value display.
## Requires exactly one placeholder (%s/%d/%f).
## You can also use it to display suffixes etc. Leave empty for no formatting.
@export var value_tooltip_custom_format: String = "":
	set = _set_value_tooltip_custom_format

@export_group("Navigation")
## Set to [code]true[/code] to enable navigation using [b]next[/b] and [b]prev[/b] buttons.
@export var navigation: bool = true:
	set = _set_navigation

## Should the naviation only appear when the button is in focus.
@export var focus_nav: bool:
	set = _set_focus_nav

## Sets the separation between navigation buttons.
@export var nav_separation: int = 4:
	set = _set_nav_separation

## The theme used for the navigation buttons.
@export var nav_theme: Theme:
	set = _set_nav_theme

## The texture used for the next navigation button.
@export var next_icon: Texture2D:
	set = _set_next_icon

## The texture used for the previous navigation button.
@export var prev_icon: Texture2D:
	set = _set_prev_icon

@export_subgroup("Navigation Behavior")
## If [code]true[/code], the navigation button is flat.
@export var nav_button_flat: bool = true:
	set = _set_nav_button_flat

## Focus mode for navigation buttons.
@export_enum("None", "Click", "All") var nav_focus_mode: int = Control.FOCUS_CLICK:
	set = _set_nav_focus_mode

## Mouse filter for navigation buttons.
@export_enum("Stop", "Pass", "Ignore") var nav_mouse_filter: int = Control.MOUSE_FILTER_STOP:
	set = _set_nav_mouse_filter

@export_group("Keyboard Control")
## Enables navigation through items using keyboard or controller.
@export var keyboard := true:
	set = _set_keyboard

## When enabled it will enable keyboard navigation by [b]Page Up[/b] and [b]Page Down[/b] keys.
## Default is [code]true[/code].
@export var keyboard_page_up_down: bool = true:
	set = _set_keyboard_page_up_down

## Stops the input from propagating further down the [code]SceneTree[/code].
## If [code]true[/code] then does not allow scrolling in ScrollContainer[br].
@export var keyboard_input_handled: bool = true:
	set = _set_keyboard_input_handled

## Set to [code]true[/code] and will release input event and allow page left/right
## when on edge positions (in the beginning or in the end).
@export var keyboard_release_on_edges: bool:
	set = _set_keyboard_release_on_edges

## Set to [code]true[/code] to allow echo event.
@export var keyboard_allow_echo: bool = false:
	set = _set_keyboard_allow_echo

## Minimum input strength to trigger item change. Default is 0.5.
## See more: [method Input.get_action_strength].
@export_range(0, 1)
var keyboard_threshold_strength: float = SBModules.KeyboardControl.TRESHOLD_STRENGTH:
	set = _set_keyboard_threshold_strength

## Action name for next item. Default is "ui_right".
@export var keyboard_next_action_name: String = SBModules.KeyboardControl.NEXT_ACTION_NAME:
	set = _set_keyboard_next_action_name

## Action name for previous item. Default is "ui_left".
@export var keyboard_prev_action_name: String = SBModules.KeyboardControl.PREV_ACTION_NAME:
	set = _set_keyboard_prev_action_name

@export_group("Mousewheel Control")
## Enables navigation through items using mouse wheel.[br] [br]
## If [code]true[/code] when [b]SpinButton[/b] has focus and has mouseover,
## then when you scroll the mouse wheel the value changes.[br] [br]
## By default, moving the mouse down selects the previous item,
## and moving the mouse up selects the next item.
@export var mousewheel: bool:
	set = _set_mousewheel

## Set to [code]true[/code] to invert spining direction.
@export var mousewheel_invert: bool:
	set = _set_mousewheel_invert

## Will spining with the mouse wheel only in focus work.[br]
## If [code]true[/code], then spining the mouse wheel only works when SpinButton is in focus.
@export var mousewheel_focus: bool = true:
	set = _set_mousewheel_focus

## Stops the input from propagating further down the [code]SceneTree[/code].
## If [code]true[/code] then does not allow scrolling in ScrollContainer.[br]
@export var mousewheel_input_handled: bool = true:
	set = _set_mousewheel_input_handled

## Set to [code]true[/code] and will release mousewheel event and allow page scrolling
## when on edge positions (in the beginning or in the end).
@export var mousewheel_release_on_edges: bool:
	set = _set_mousewheel_release_on_edges

var navigation_module: SBModules.Navigation
var keyboard_control: SBModules.KeyboardControl
var mousewheel_control: SBModules.MousewheelControl

# endregion

# region Built-in


func _custom_init() -> void:
	_custom_properties()
	_init_modules()


func _custom_input(event) -> void:
	if disabled:
		return

	_mousewheel_input(event)

	if has_focus():
		keyboard_control.input(event)


func _mousewheel_input(event) -> void:
	if is_hovered() and not disabled:
		if mousewheel_focus and has_focus():
			mousewheel_control.input(event)
		elif not mousewheel_focus:
			mousewheel_control.input(event)


func _custom_properties() -> void:
	value_button.clip_contents = false


func _custom_initialize() -> void:
	value_button.show()
	slider_wrapper.show()

	_initialize_modules()
	_setup_signals()
	_setup_variables()


# endregion

# region Public methods


## Increases the value by [code]step[/code].
func next_step() -> void:
	slider.value += step


## Decreases the value by [code]step[/code].
func prev_step() -> void:
	slider.value -= step


# endregion

# region Setters & Getters


func _set_editable(value: bool) -> void:
	editable = value
	slider.editable = value


func _set_scrollable(value: bool) -> void:
	scrollable = value
	slider.scrollable = value


func _set_tick_count(value: int) -> void:
	tick_count = value
	slider.tick_count = value


func _set_ticks_on_borders(value: bool) -> void:
	ticks_on_borders = value
	slider.ticks_on_borders = value


func _set_min_value(value: float) -> void:
	min_value = value
	slider.min_value = value


func _set_max_value(value: float) -> void:
	max_value = value
	slider.max_value = value


func _set_step(value: float) -> void:
	step = value
	slider.step = value


func _set_page(value: float) -> void:
	page = value
	slider.page = value


func _set_value(val: float) -> void:
	value = val
	slider.value = val

	if _is_initialized:
		_update_value_text()
		_update_value_tooltip()


func _set_exp_edit(value: bool) -> void:
	exp_edit = value
	slider.exp_edit = value


func _set_rounded(value: bool) -> void:
	rounded = value
	slider.rounded = value


func _set_allow_greater(value: bool) -> void:
	allow_greater = value
	slider.allow_greater = value


func _set_allow_lesser(value: bool) -> void:
	allow_lesser = value
	slider.allow_lesser = value


func _set_value_label_placement(value: ValuePlacement) -> void:
	value_label_placement = value

	if _is_initialized:
		_update_value_label_placement()


func _set_value_separation(value: int) -> void:
	value_separation = value

	if _is_initialized:
		_update_value_separation()


func _set_value_label_custom_format(value: String) -> void:
	value_label_custom_format = value

	if _is_initialized:
		_update_value_text()


func _set_value_label_visibility(value: Visibility) -> void:
	value_label_visibility = value

	if _is_initialized:
		_update_visibility(slider_value, value)


func _set_value_tooltip_placement(value: ValuePlacement) -> void:
	value_tooltip_placement = value

	if _is_initialized:
		_update_value_tooltip()


func _set_value_tooltip_visibility(value: Visibility) -> void:
	value_tooltip_visibility = value

	if _is_initialized:
		_update_value_tooltip_visibility()


func _set_value_tooltip_separation(value: int) -> void:
	value_tooltip_separation = value

	if _is_initialized:
		_update_value_tooltip_visibility()


func _set_value_tooltip_custom_format(value: String) -> void:
	value_tooltip_custom_format = value

	if _is_initialized:
		_update_value_text()


func _set_navigation(value: bool) -> void:
	navigation = value
	navigation_module.enabled = value


func _set_focus_nav(value: bool) -> void:
	focus_nav = value
	navigation_module.focus_nav = value


func _set_nav_separation(value: int) -> void:
	nav_separation = value

	if _is_initialized:
		content_container.add_theme_constant_override("separation", value)


func _set_nav_theme(value: Theme) -> void:
	nav_theme = value

	if _is_initialized:
		prev_button.theme = value
		next_button.theme = value


func _set_next_icon(value: Texture2D) -> void:
	next_icon = value
	next_button.icon = value
	navigation_module.update_visible()


func _set_prev_icon(value: Texture2D) -> void:
	prev_icon = value
	prev_button.icon = value
	navigation_module.update_visible()


func _set_nav_button_flat(value: bool) -> void:
	nav_button_flat = value

	if _is_initialized:
		prev_button.flat = value
		next_button.flat = value


func _set_nav_focus_mode(value: FocusMode) -> void:
	nav_focus_mode = value

	if _is_initialized:
		navigation_module.focus_mode = value


func _set_nav_mouse_filter(value: MouseFilter) -> void:
	nav_mouse_filter = value

	if _is_initialized:
		navigation_module.mouse_filter = value


func _set_keyboard(value: bool) -> void:
	keyboard = value
	keyboard_control.enabled = value


func _set_keyboard_page_up_down(value: bool) -> void:
	keyboard_page_up_down = value
	keyboard_control.page_up_down = value


func _set_keyboard_input_handled(value: bool) -> void:
	keyboard_input_handled = value
	keyboard_control.input_handled = value


func _set_keyboard_release_on_edges(value: bool) -> void:
	keyboard_release_on_edges = value
	keyboard_control.release_on_edges = value


func _set_keyboard_allow_echo(value: bool) -> void:
	keyboard_allow_echo = value
	keyboard_control.allow_echo = value


func _set_keyboard_threshold_strength(value: float) -> void:
	keyboard_threshold_strength = value
	keyboard_control.threshold_strength = value


func _set_keyboard_next_action_name(value: String) -> void:
	keyboard_next_action_name = value
	keyboard_control.next_action_name = value


func _set_keyboard_prev_action_name(value: String) -> void:
	keyboard_prev_action_name = value
	keyboard_control.prev_action_name = value


func _set_mousewheel(value: bool) -> void:
	mousewheel = value
	mousewheel_control.enabled = value


func _set_mousewheel_invert(value: bool) -> void:
	mousewheel_invert = value
	mousewheel_control.invert = value


func _set_mousewheel_focus(value: bool) -> void:
	mousewheel_focus = value


func _set_mousewheel_input_handled(value: bool) -> void:
	mousewheel_input_handled = value
	mousewheel_control.input_handled = value


func _set_mousewheel_release_on_edges(value: bool) -> void:
	mousewheel_release_on_edges = value
	mousewheel_control.release_on_edges = value


# endregion

# region Init methods


func _init_navigation() -> void:
	navigation_module = SBModules.Navigation.new()
	navigation_module.enabled = navigation
	navigation_module.disable_on_edges = true
	navigation_module.disabled_buttons = disabled


func _init_keyboard_control() -> void:
	keyboard_control = SBModules.KeyboardControl.new()
	keyboard_control.enabled = keyboard
	keyboard_control.input_handled = keyboard_input_handled
	keyboard_control.release_on_edges = keyboard_release_on_edges


func _init_mousewheel_control() -> void:
	mousewheel_control = SBModules.MousewheelControl.new()
	mousewheel_control.enabled = mousewheel
	mousewheel_control.input_handled = mousewheel_input_handled
	mousewheel_control.invert = mousewheel_invert
	mousewheel_control.release_on_edges = mousewheel_release_on_edges


func _init_modules() -> void:
	_init_navigation()
	_init_keyboard_control()
	_init_mousewheel_control()


func _initialize_modules() -> void:
	navigation_module.initialize(self)
	navigation_module.focus_nav = focus_nav
	navigation_module.focus_mode = nav_focus_mode
	navigation_module.mouse_filter = nav_mouse_filter
	keyboard_control.initialize(get_viewport())
	mousewheel_control.initialize(get_viewport())


func _setup_signals() -> void:
	edged.connect(Callable(self, "_on_edged"))
	focus_entered.connect(Callable(self, "_on_focus_entered"))
	focus_exited.connect(Callable(self, "_on_focus_exited"))
	mouse_entered.connect(Callable(self, "_on_mouse_entered"))
	mouse_exited.connect(Callable(self, "_on_mouse_exited"))
	slider.minimum_size_changed.connect(Callable(self, "_on_slider_minimum_size_changed"))
	slider.focus_entered.connect(Callable(self, "_on_focus_entered"))
	slider.focus_exited.connect(Callable(self, "_on_focus_exited"))
	slider.mouse_entered.connect(Callable(self, "_on_mouse_entered"))
	slider.mouse_exited.connect(Callable(self, "_on_mouse_exited"))
	slider.value_changed.connect(Callable(self, "_on_value_changed"))
	slider.gui_input.connect(Callable(self, "_on_slider_gui_input"))
	next_button.pressed.connect(Callable(self, "_on_next_button_pressed"))
	prev_button.pressed.connect(Callable(self, "_on_prev_button_pressed"))
	keyboard_control.next_input.connect(Callable(self, "_on_next_button_pressed"))
	keyboard_control.prev_input.connect(Callable(self, "_on_prev_button_pressed"))
	mousewheel_control.next_input.connect(Callable(self, "_on_next_button_pressed"))
	mousewheel_control.prev_input.connect(Callable(self, "_on_prev_button_pressed"))


func _setup_variables() -> void:
	prev_button.theme = nav_theme
	next_button.theme = nav_theme
	prev_button.flat = nav_button_flat
	next_button.flat = nav_button_flat
	content_container.add_theme_constant_override("separation", nav_separation)
	_update_edges(value == min_value, value == max_value)
	_update_value_text()
	_update_visibility(slider_value, value_label_visibility)
	_update_value_label_placement()
	_update_value_separation()
	_update_value_tooltip_visibility()
	_update_value_tooltip()


# endregion

# region Private methods


func _update_edges(start: bool, end: bool) -> void:
	navigation_module.set_edges(start, end)
	keyboard_control.set_edges(start, end)


func _update_value_text() -> void:
	if value_label_custom_format.is_empty():
		slider_value.text = str(slider.value)
	else:
		slider_value.text = value_label_custom_format % slider.value

	if value_tooltip_custom_format.is_empty():
		slider_value_tooltip.text = str(slider.value)
	else:
		slider_value_tooltip.text = value_tooltip_custom_format % slider.value


func _update_value_label_placement() -> void:
	match value_label_placement:
		ValuePlacement.LEFT, ValuePlacement.RIGHT:
			_update_value_container(slider_container_h, slider_container_v, H_SLIDER_CONTAINER_NAME)
		ValuePlacement.TOP, ValuePlacement.BOTTOM:
			_update_value_container(slider_container_v, slider_container_h, V_SLIDER_CONTAINER_NAME)
		ValuePlacement.CENTER:
			if slider_value.get_parent().name != SLIDER_WRAPPER_NAME:
				slider_value.reparent(slider_wrapper)


func _update_value_separation() -> void:
	slider_container_h.add_theme_constant_override(&"separation", value_separation)
	slider_container_v.add_theme_constant_override(&"separation", value_separation)


func _update_value_tooltip() -> void:
	var pos := Vector2.ZERO
	var grabber_size := slider.get_theme_icon(&"Grabber").get_size()

	pos.x = slider.ratio * (slider.size.x - grabber_size.x) + grabber_size.x * 0.5

	match value_tooltip_placement:
		ValuePlacement.TOP:
			pos.x -= slider_value_tooltip.size.x * 0.5
			pos.y = -slider_value_tooltip.size.y - value_tooltip_separation
		ValuePlacement.BOTTOM:
			pos.x -= slider_value_tooltip.size.x * 0.5
			pos.y = slider.size.y + value_tooltip_separation
		ValuePlacement.LEFT:
			pos.x -= slider.size.y - value_tooltip_separation
			pos.y = slider_value_tooltip.size.y * 0.5
		ValuePlacement.RIGHT:
			pos.x += (-slider_value_tooltip.size.x + slider.size.y + value_tooltip_separation)
			pos.y = slider_value_tooltip.size.y * 0.5
		ValuePlacement.CENTER:
			pos.x -= slider_value_tooltip.size.x * 0.5
			pos.y = slider_value_tooltip.size.y * 0.5

	slider_value_tooltip.position = pos


func _update_value_tooltip_visibility() -> void:
	if Engine.is_editor_hint():
		slider_value_tooltip.hide()
		return

	match value_tooltip_visibility:
		Visibility.NEVER:
			slider_value_tooltip.hide()
		Visibility.ALWAYS:
			slider_value_tooltip.show()
		Visibility.CLICK:
			slider_value_tooltip.hide()
		Visibility.FOCUS:
			if has_focus() or slider.has_focus():
				slider_value_tooltip.show()
			else:
				slider_value_tooltip.hide()
		Visibility.HOVER:
			if is_hovered():
				slider_value_tooltip.show()
			else:
				slider_value_tooltip.hide()


func _update_value_container(
	container_to_show: Node, container_to_hide: Node, container_name: String
) -> void:
	if slider_value.get_parent().name != container_name:
		container_to_show.show()
		slider.reparent(container_to_show)
		slider_value.reparent(container_to_show)
		container_to_hide.hide()

	var index_slider := slider.get_index()
	var index_value := slider_value.get_index()

	if (
		value_label_placement in [ValuePlacement.LEFT, ValuePlacement.TOP]
		and index_value > index_slider
	):
		container_to_show.move_child(slider, index_value)
	elif (
		value_label_placement in [ValuePlacement.RIGHT, ValuePlacement.BOTTOM]
		and index_slider > index_value
	):
		container_to_show.move_child(slider, index_value)


# endregion

# region Signals


func _on_value_changed(val: float) -> void:
	value = val
	if _is_initialized:
		_update_value_text()
		_update_value_tooltip()
	emit_signal("value_changed", val)
	emit_signal("edged", val == slider.min_value, val == slider.max_value)


func _on_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if value_tooltip_visibility == Visibility.CLICK:
			slider_value_tooltip.visible = event.pressed
		_update_value_tooltip()


func _on_next_button_pressed() -> void:
	next_step()


func _on_prev_button_pressed() -> void:
	prev_step()


func _on_edged(start: bool, end: bool) -> void:
	_update_edges(start, end)


func _on_slider_minimum_size_changed() -> void:
	_update_value_tooltip()


func _on_focus_entered() -> void:
	_update_visibility(slider_value, value_label_visibility)
	if value_tooltip_visibility == Visibility.FOCUS:
		_update_value_tooltip()
		slider_value_tooltip.show()


func _on_focus_exited() -> void:
	_update_visibility(slider_value, value_label_visibility)
	if value_tooltip_visibility == Visibility.FOCUS:
		slider_value_tooltip.hide()


func _on_mouse_entered() -> void:
	_update_visibility(slider_value, value_label_visibility)
	if value_tooltip_visibility == Visibility.HOVER:
		_update_value_tooltip()
		slider_value_tooltip.show()


func _on_mouse_exited() -> void:
	_update_visibility(slider_value, value_label_visibility)
	if value_tooltip_visibility == Visibility.HOVER:
		slider_value_tooltip.hide()

# endregion
