@tool
extends RefCounted

## Boolean property to use to enable/disable navigation.
var enabled: bool = true:
	set = _set_enabled

## Boolean property that determines whether the navigation buttons
## will be displayed during focus or continuously.
## Set [code]true[/code] so that the navigation buttons are displayed [b]only when in focus[/b].
var focus_nav: bool:
	set = _set_focus_nav

## Boolean property that determines whether the navigation buttons
## will be disabled on the edges.
var disable_on_edges: bool:
	set = _set_disable_on_edges

## Sets the disabled property for navigation buttons.
var disabled_buttons: bool:
	set = _set_disabled_buttons

## Sets the focus mode for navigation buttons.
var focus_mode: int = Control.FOCUS_CLICK:
	set = _set_focus_mode

## Sets the mouse filter for navigation buttons.
var mouse_filter: int = Control.MOUSE_FILTER_STOP:
	set = _set_mouse_filter

var _initialized: bool
var _owner: SBBaseButton
var _edge_start: bool
var _edge_end: bool
var _next: Button
var _prev: Button


## Initializes the navigation module.
func initialize(owner: SBBaseButton) -> void:
	if _initialized:
		return

	_owner = owner
	_next = _owner.next_button
	_prev = _owner.prev_button

	_connect_signals()
	_init_buttons()
	_initialized = true
	update_visible()


## Disable navigation.
func disable() -> void:
	enabled = false


## Enable navigation.
func enable() -> void:
	enabled = true


## Set to [code]true[/code] and will release input event and allow page left/right
## when on edge positions (in the beginning or in the end).
func set_edges(edge_start: bool = false, edge_end: bool = false) -> void:
	_edge_start = edge_start
	_edge_end = edge_end
	_update_disable_edges()


func _set_enabled(value: bool) -> void:
	enabled = value

	if not _initialized:
		return

	_next.visible = value
	_prev.visible = value


func _set_focus_nav(value: bool) -> void:
	focus_nav = value

	if not _initialized:
		return

	if value:
		if _owner.has_focus():
			_show_buttons()
		else:
			_hide_buttons()
	else:
		_show_buttons()


func _set_disable_on_edges(value: bool) -> void:
	disable_on_edges = value

	if _initialized:
		_update_disable_edges()


func _set_disabled_buttons(value: bool) -> void:
	disabled_buttons = value

	if _initialized:
		_next.disabled = value
		_prev.disabled = value


func _set_focus_mode(value: Control.FocusMode) -> void:
	focus_mode = value

	if _initialized:
		_next.focus_mode = value
		_prev.focus_mode = value


func _set_mouse_filter(value: Control.MouseFilter) -> void:
	mouse_filter = value

	if _initialized:
		_next.mouse_filter = value
		_prev.mouse_filter = value


func update_visible() -> void:
	if not _initialized or not enabled:
		return

	if focus_nav and _owner.has_focus() or not focus_nav:
		if _next.icon:
			_next.show()
		if _prev.icon:
			_prev.show()


func _init_buttons() -> void:
	if not enabled:
		return

	_next.focus_mode = focus_mode
	_prev.focus_mode = focus_mode

	_next.mouse_filter = mouse_filter
	_prev.mouse_filter = mouse_filter

	update_visible()


func _connect_signals() -> void:
	_owner.focus_entered.connect(Callable(self, "_on_focus_entered"))
	_owner.focus_exited.connect(Callable(self, "_on_focus_exited"))


func _update_disable_edges() -> void:
	if not _initialized:
		return

	if disable_on_edges:
		_next.disabled = _edge_end
		_prev.disabled = _edge_start
	else:
		_next.disabled = false
		_prev.disabled = false


func _show_buttons() -> void:
	if not _initialized:
		return

	_next.show()
	_prev.show()


func _hide_buttons() -> void:
	if not _initialized:
		return

	_next.hide()
	_prev.hide()


func _on_focus_entered() -> void:
	if not enabled or not _initialized:
		return

	if focus_nav:
		_show_buttons()


func _on_focus_exited() -> void:
	if not enabled or not _initialized:
		return

	if focus_nav:
		_hide_buttons()
