## A spin button that represents a selectable items with prev and next buttons.
@tool
@icon("res://addons/spin_button/assets/icons/sb_spin.png")
class_name SBSpinButton
extends SBButton

## Emitted when an item is selected.
signal item_selected(index: int)

## Emitted when the number of items changes.
signal length_changed(length: int)

## Emitted when the navigation edges are reached.
signal edged(start: bool, end: bool)

const NONE_SELECTED := -1

# region Properties

## The items to display in the spin button.
@export var items: Array[String] = []:
	set = set_items,
	get = get_items

## The index of the currently selected item, or -1 if no item is selected.
@export var selected: int = NONE_SELECTED:
	set = _set_selected,
	get = get_selected

## The number of items in the spin button.
@export var item_count: int = 0:
	set = set_item_count,
	get = get_item_count

## Set to [code]true[/code] to enable continuous loop mode.[br] [br]
## When enabled, clicking [b]next[/b] navigation button (or calling [method spin_next]),
## when on last item will spin back to the first item.[br] [br]
## Clicking [b]prev[/b] navigation button (or calling [method spin_prev]),
## when on first item will spin forward to the last item.
@export var loop: bool:
	set = _set_loop

@export_group("Popup")
## Set to [code]true[/code] to show the popup when clicking on the button.
@export var is_show_popup: bool:
	set = _set_is_show_popup

## Set to [code]true[/code] to allow selecting the same item again.
@export var popup_allow_reselect: bool:
	set = _set_popup_allow_reselect

## Set to [code]true[/code] to open the popup by button click, not just by value.
@export var open_popup_button: bool

@export_group("Navigation")
## Set to [code]true[/code] to enable navigation using [b]next[/b] and [b]prev[/b] buttons.
@export var navigation: bool = true:
	set = _set_navigation

## Should the naviation only appear when the button is in focus.
@export var focus_nav: bool:
	set = _set_focus_nav

## Sets the separation between navigation buttons.
@export var nav_separation: int = 0:
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

@export_group("Pagination")
## Set to [code]true[/code] to enable pagination.
@export var pagination: bool:
	set = _set_pagination

## If true then clicking on pagination button will cause transition to appropriate item.
@export var clickable_bullets: bool:
	set = _set_clickable_bullets

## Whether the bullets have to fill all the available space.
@export var fill_bullets: bool:
	set = _set_fill_bullets

## Should bullets be displayed when the button has focus.
@export var focus_bullets: bool:
	set = _set_focus_bullets

## The size of each bullet.
@export var bullet_size := Vector2(4, 4):
	set = _set_bullet_size

## The separation between each bullet.
@export var bullet_separation := 4:
	set = _set_bullet_separation

## The separation between each bullet.
@export var bullet_margin := 0:
	set = _set_bullet_margin

@export_subgroup("Bullet Styles")
## The style of active bullet.
@export var bullet_style: StyleBox:
	set = _set_bullet_style

## The style of inactive bullet.
@export var bullet_inactive_style: StyleBox:
	set = _set_bullet_inactive_style

## The style of hovered active bullet.
@export var bullet_hover: StyleBox:
	set = _set_bullet_hover

## The style of hovered inactive bullet.
@export var bullet_inactive_hover: StyleBox:
	set = _set_bullet_inactive_hover

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

## Node containing the element of the container that accepts mouse wheel events.
## By default it is [b]SpinButton[/b].
@export var mousewheel_events_target: SBModules.MousewheelControl.MousewheelTargets = (
	SBModules.MousewheelControl.MousewheelTargets.ALL
):
	set = _set_mousewheel_events_target

## Index number of previously selected item.
var previous_selected: int = NONE_SELECTED

var manipulation_module: SBModules.Manipulation
var navigation_module: SBModules.Navigation
var pagination_module: SBModules.Pagination
var keyboard_control: SBModules.KeyboardControl
var mousewheel_control: SBModules.MousewheelControl

# endregion

# region Built-in


func _custom_init() -> void:
	_init_modules()


func _custom_input(event) -> void:
	if disabled:
		return

	if mousewheel_events_target == SBModules.MousewheelControl.MousewheelTargets.ALL:
		_mousewheel_input(event)

	if has_focus():
		keyboard_control.input(event)


func _mousewheel_input(event) -> void:
	if is_hovered() and not disabled:
		if mousewheel_focus and has_focus():
			mousewheel_control.input(event)
		elif not mousewheel_focus:
			mousewheel_control.input(event)


func _custom_initialize() -> void:
	value_button.show()
	value_text_container.show()

	_initialize_modules()
	_setup_signals()
	_setup_variables()

	select(selected)


# endregion

# region Public methods


## Set the items of the list.
func set_items(value: Array[String]) -> void:
	if selected > value.size() - 1:
		selected = maxi(NONE_SELECTED, value.size() - 1)

	if value.size() != items.size():
		item_count = value.size()

	manipulation_module.list = value
	_update_popup_items()
	_update_text()


## Get the items of the list.
func get_items() -> Array[String]:
	return manipulation_module.list


## Get the selected index. Returns -1 if no item is selected.
func get_selected() -> int:
	return manipulation_module.active_index


## Get the selected item. Returns an empty string if no item is selected.
func get_selected_item() -> String:
	if selected == NONE_SELECTED:
		return ""

	return items[selected]


## Set the number of items.
func set_item_count(value: int) -> void:
	if value < 0:
		return

	var prev_size := items.size()

	if value == prev_size:
		return

	if selected >= value:
		selected = min(selected, value - 1)

	items.resize(value)

	emit_signal("length_changed", item_count)


## Get the number of items.
func get_item_count() -> int:
	return items.size()


## Selects an item by index and makes it the current item.
## Passing -1 as the index deselects any currently selected item.
func select(index: int) -> void:
	selected = index


## Deselects the currently selected item.
func deselect() -> void:
	selected = NONE_SELECTED


## Spin to the previous item.
func spin_prev() -> void:
	if get_item_count() > 0:
		if loop:
			selected = (selected - 1 + get_item_count()) % get_item_count()
		else:
			if selected > 0:
				selected -= 1


## Spin to the next item.
func spin_next() -> void:
	if get_item_count() > 0:
		if loop:
			selected = (selected + 1) % get_item_count()
		else:
			if selected < get_item_count() - 1:
				selected += 1


## Add new items to the end.
## Items could be new item or array with such items.
func append_item(items) -> void:
	manipulation_module.append_item(items)
	emit_signal("length_changed", item_count)


## Add new items to the beginning.
## Items could be new item or array with such items.
func prepend_item(items) -> void:
	manipulation_module.prepend_item(items)
	emit_signal("length_changed", item_count)


## Add new items to the required index.
## Items could be new item or array with such items.
func add_item(items, idx: int = -1) -> void:
	manipulation_module.add_item(idx, items)
	emit_signal("length_changed", item_count)


## Remove all items.
func remove_all_items() -> void:
	manipulation_module.remove_all_items()
	emit_signal("length_changed", item_count)


## Remove selected items.
## items_indexes could be a number with item index to remove or array with indexes.
func remove_item(items_indexes) -> void:
	manipulation_module.remove_item(items_indexes)
	emit_signal("length_changed", item_count)


## Returns the [member PopupMenu] contained in this button.
func get_popup() -> PopupMenu:
	return value_button.get_popup()


# endregion

# region Setters & Getters


func _set_selected(value: int) -> void:
	var new_value: int = NONE_SELECTED

	if value > NONE_SELECTED and value < get_item_count():
		new_value = value

	previous_selected = selected
	manipulation_module.active_index = new_value

	emit_signal("item_selected", new_value)
	emit_signal("edged", new_value <= 0, new_value == get_item_count() - 1)


func _set_loop(value: bool) -> void:
	loop = value
	navigation_module.disable_on_edges = not value


func _set_is_show_popup(value: bool) -> void:
	is_show_popup = value
	value_button.is_show_popup = value
	value_mouse_filter = Control.MOUSE_FILTER_PASS if value else Control.MOUSE_FILTER_IGNORE


func _set_popup_allow_reselect(value: bool) -> void:
	popup_allow_reselect = value
	value_button.allow_reselect = value


func _set_navigation(value: bool) -> void:
	navigation = value
	navigation_module.enabled = value


func _set_nav_separation(value: int) -> void:
	nav_separation = value

	if _is_initialized:
		content_container.add_theme_constant_override("separation", value)


func _set_nav_theme(value: Theme) -> void:
	nav_theme = value

	if _is_initialized:
		prev_button.theme = value
		next_button.theme = value


func _set_nav_button_flat(value: bool) -> void:
	nav_button_flat = value

	if _is_initialized:
		prev_button.flat = value
		next_button.flat = value


func _set_next_icon(value: Texture2D) -> void:
	next_icon = value
	next_button.icon = value
	navigation_module.update_visible()


func _set_prev_icon(value: Texture2D) -> void:
	prev_icon = value
	prev_button.icon = value
	navigation_module.update_visible()


func _set_focus_nav(value: bool) -> void:
	focus_nav = value
	navigation_module.focus_nav = value


func _set_nav_focus_mode(value: FocusMode) -> void:
	nav_focus_mode = value

	if _is_initialized:
		navigation_module.focus_mode = value


func _set_nav_mouse_filter(value: MouseFilter) -> void:
	nav_mouse_filter = value

	if _is_initialized:
		navigation_module.mouse_filter = value


func _set_pagination(value: bool) -> void:
	pagination = value
	pagination_module.enabled = value


func _set_clickable_bullets(value: bool) -> void:
	clickable_bullets = value
	pagination_module.clickable = value


func _set_fill_bullets(value: bool) -> void:
	fill_bullets = value
	pagination_module.fill_bullets = value


func _set_focus_bullets(value: bool) -> void:
	focus_bullets = value
	pagination_module.focus_bullets = value


func _set_bullet_size(value: Vector2) -> void:
	bullet_size = value
	pagination_module.bullet_size = value


func _set_bullet_separation(value: int) -> void:
	bullet_separation = value
	pagination_module.bullet_separation = value


func _set_bullet_margin(value: int) -> void:
	bullet_margin = value
	pagination_module.bullet_margin = value


func _set_bullet_style(value: StyleBox) -> void:
	bullet_style = value
	pagination_module.bullet_style = value


func _set_bullet_inactive_style(value: StyleBox) -> void:
	bullet_inactive_style = value
	pagination_module.bullet_inactive_style = value


func _set_bullet_hover(value: StyleBox) -> void:
	bullet_hover = value
	pagination_module.bullet_hover = value


func _set_bullet_inactive_hover(value: StyleBox) -> void:
	bullet_inactive_hover = value
	pagination_module.bullet_inactive_hover = value


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


func _set_mousewheel_events_target(value: int) -> void:
	mousewheel_events_target = value


# endregion

# region Init methods


func _init_manipulation() -> void:
	manipulation_module = SBModules.Manipulation.new()


func _init_popup() -> void:
	value_button.is_show_popup = is_show_popup
	value_button.allow_reselect = popup_allow_reselect


func _init_navigation() -> void:
	navigation_module = SBModules.Navigation.new()
	navigation_module.enabled = navigation
	navigation_module.disable_on_edges = not loop
	navigation_module.disabled_buttons = disabled


func _init_pagination() -> void:
	pagination_module = SBModules.Pagination.new()
	pagination_module.enabled = pagination
	pagination_module.clickable = clickable_bullets
	pagination_module.fill_bullets = fill_bullets
	pagination_module.focus_bullets = focus_bullets
	pagination_module.bullet_size = bullet_size
	pagination_module.bullet_separation = bullet_separation
	pagination_module.bullet_style = bullet_style
	pagination_module.bullet_inactive_style = bullet_inactive_style
	pagination_module.bullet_hover = bullet_hover
	pagination_module.bullet_inactive_hover = bullet_inactive_hover


func _init_keyboard_control() -> void:
	keyboard_control = SBModules.KeyboardControl.new()
	keyboard_control.enabled = keyboard
	keyboard_control.page_up_down = keyboard_page_up_down
	keyboard_control.threshold_strength = keyboard_threshold_strength
	keyboard_control.next_action_name = keyboard_next_action_name
	keyboard_control.prev_action_name = keyboard_prev_action_name
	keyboard_control.input_handled = keyboard_input_handled
	keyboard_control.release_on_edges = keyboard_release_on_edges


func _init_mousewheel_control() -> void:
	mousewheel_control = SBModules.MousewheelControl.new()
	mousewheel_control.enabled = mousewheel
	mousewheel_control.input_handled = mousewheel_input_handled
	mousewheel_control.invert = mousewheel_invert
	mousewheel_control.release_on_edges = mousewheel_release_on_edges


func _init_modules() -> void:
	_init_manipulation()
	_init_popup()
	_init_navigation()
	_init_pagination()
	_init_keyboard_control()
	_init_mousewheel_control()


func _initialize_modules() -> void:
	navigation_module.initialize(self)
	navigation_module.focus_nav = focus_nav
	navigation_module.focus_mode = nav_focus_mode
	navigation_module.mouse_filter = nav_mouse_filter
	pagination_module.initialize(self)
	keyboard_control.initialize(get_viewport())
	mousewheel_control.initialize(get_viewport())


func _setup_signals() -> void:
	pressed.connect(Callable(self, "_on_pressed"))
	edged.connect(Callable(self, "_on_edged"))
	item_selected.connect(Callable(self, "_on_item_selected"))
	length_changed.connect(Callable(self, "_on_length_changed"))
	next_pressed.connect(Callable(self, "_on_next_button_pressed"))
	prev_pressed.connect(Callable(self, "_on_prev_button_pressed"))
	value_button.item_selected.connect(Callable(self, "_on_value_button_item_selected"))
	keyboard_control.next_input.connect(Callable(self, "_on_next_button_pressed"))
	keyboard_control.prev_input.connect(Callable(self, "_on_prev_button_pressed"))
	mousewheel_control.next_input.connect(Callable(self, "_on_next_button_pressed"))
	mousewheel_control.prev_input.connect(Callable(self, "_on_prev_button_pressed"))
	value_button.gui_input.connect(Callable(self, "_on_value_button_gui_input"))


func _setup_variables() -> void:
	_update_popup_items()
	prev_button.theme = nav_theme
	next_button.theme = nav_theme
	prev_button.flat = nav_button_flat
	next_button.flat = nav_button_flat
	content_container.add_theme_constant_override("separation", nav_separation)


# endregion

# region Private methods


func _open_popup() -> void:
	var vb_pos := value_button.get_screen_position()
	var vb_popup := value_button.get_popup()
	vb_popup.position = Vector2(vb_pos.x, vb_pos.y + size.y)
	vb_popup.size.x = value_button.size.x
	vb_popup.popup()


func _update_edges(start: bool, end: bool) -> void:
	navigation_module.set_edges(start, end)
	keyboard_control.set_edges(start, end)
	mousewheel_control.set_edges(start, end)


func _update_popup_items() -> void:
	value_button.clear()
	for item in items:
		value_button.add_item(item)


func _update_text() -> void:
	if value_text_label:
		value_text_label.text = get_selected_item()


# endregion

# region Signals


func _on_pressed() -> void:
	if is_show_popup and open_popup_button:
		_open_popup()


func _on_edged(start: bool, end: bool) -> void:
	_update_edges(start, end)


func _on_item_selected(_index: int) -> void:
	_update_text()
	if value_button:
		value_button.select(selected)


func _on_length_changed(_index: int) -> void:
	_update_text()
	_update_popup_items()
	value_button.select(selected)
	pagination_module.select(selected)
	pagination_module.set_bullet_count(item_count)


func _on_next_button_pressed() -> void:
	spin_next()


func _on_prev_button_pressed() -> void:
	spin_prev()


func _on_value_button_item_selected(index: int) -> void:
	select(index)


func _on_value_button_gui_input(event) -> void:
	if mousewheel_events_target == SBModules.MousewheelControl.MousewheelTargets.VALUE:
		_mousewheel_input(event)

# endregion
