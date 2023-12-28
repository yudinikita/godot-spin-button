@tool
extends RefCounted

## Event is triggered when the mouse wheel is scrolled.
signal scrolled(event: InputEvent)

## Event is triggered when mousewheel is scrolled to enter previous value.
signal prev_input

## Event is triggered when mousewheel is scrolled to enter next value.
signal next_input

## Element of the node that accepts mouse wheel events
enum MousewheelTargets {
	##
	ALL,  ## Switching with the mouse wheel is triggered across the [b]entire surface[/b].
	##
	VALUE,  ## Switching with the mouse wheel takes place only on the [b]value surface[/b].
}

## Whether the mousewheel control is initialized.
var initialized: bool

## Whether the mousewheel control is enabled.
## Set to [code]true[/code] to enable keyboard control.
var enabled: bool

## Set to [code]true[/code] to invert switching direction.
var invert: bool

## Stops the input from propagating further down the [code]SceneTree[/code].
## If [code]true[/code] then does not allow scrolling in ScrollContainer.[br]
var input_handled: bool = true

## Set to [code]true[/code] and will release mousewheel event and allow page scrolling
## when on edge positions (in the beginning or in the end).
var release_on_edges: bool

var _viewport: Viewport
var _edge_start: bool
var _edge_end: bool


## Initialize mousewheel control.
func initialize(viewport: Viewport) -> void:
	if initialized:
		return

	_viewport = viewport
	initialized = true


## Disable mousewheel control.
func disable() -> void:
	enabled = false


## Enable mousewheel control.
func enable() -> void:
	enabled = true


## Set to [code]true[/code] and will release input event and allow page left/right
## when on edge positions (in the beginning or in the end).
func set_edges(edge_start: bool = false, edge_end: bool = false) -> void:
	_edge_start = edge_start
	_edge_end = edge_end


## Called when there is an input event.
func input(event: InputEvent) -> void:
	if not enabled or not initialized:
		return

	if event is InputEventMouseButton:
		if (
			(
				event.button_index == MOUSE_BUTTON_WHEEL_DOWN
				or event.button_index == MOUSE_BUTTON_WHEEL_UP
			)
			and event.pressed
		):
			emit_signal("scrolled", event)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if invert:
					_next_input()
				else:
					_prev_input()
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if invert:
					_prev_input()
				else:
					_next_input()


func _prev_input() -> void:
	if input_handled:
		if release_on_edges and _edge_start:
			return
		_viewport.set_input_as_handled()
	emit_signal("prev_input")


func _next_input() -> void:
	if input_handled:
		if release_on_edges and _edge_end:
			return
		_viewport.set_input_as_handled()
	emit_signal("next_input")
