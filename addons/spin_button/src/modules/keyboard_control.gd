@tool
extends RefCounted

## Event is triggered when key is pressed to enter previous value.
signal prev_input

## Event is triggered when key is pressed to enter next value.
signal next_input

const TRESHOLD_STRENGTH := 0.5
const PREV_ACTION_NAME := "ui_left"
const NEXT_ACTION_NAME := "ui_right"

## Whether the keyboard control is initialized.
var initialized: bool

## Whether the keyboard control is enabled.
## Set to [code]true[/code] to enable keyboard control.
var enabled: bool

## When enabled it will enable keyboard navigation by [b]Page Up[/b] and [b]Page Down[/b] keys.
## Default is [code]true[/code].
var page_up_down: bool = true

## Minimum input strength to trigger item change. Default is 0.5.
## See more: [method Input.get_action_strength].
var threshold_strength: float = TRESHOLD_STRENGTH

## Action name for next item. Default is "ui_right".
var next_action_name: String = NEXT_ACTION_NAME

## Action name for previous item. Default is "ui_left".
var prev_action_name: String = PREV_ACTION_NAME

## Stops the input from propagating further down the [code]SceneTree[/code].
## If [code]true[/code] then does not allow scrolling in ScrollContainer.[br]
var input_handled: bool = true

## Set to [code]true[/code] and will release input event and allow page left/right
## when on edge positions (in the beginning or in the end).
var release_on_edges: bool

## Set to [code]true[/code] to allow echo event.
var allow_echo: bool = false

var _viewport: Viewport
var _edge_start: bool
var _edge_end: bool


## Initialize keyboard control.
func initialize(viewport: Viewport) -> void:
	if initialized:
		return

	_viewport = viewport
	initialized = true


## Disable keyboard control.
func disable() -> void:
	enabled = false


## Enable keyboard control.
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

	if (
		event.is_action_pressed(prev_action_name, allow_echo)
		and Input.get_action_strength(prev_action_name) > threshold_strength
	):
		_prev_input()
	elif (
		event.is_action_pressed(next_action_name, allow_echo)
		and Input.get_action_strength(next_action_name) > threshold_strength
	):
		_next_input()

	if page_up_down:
		if event.is_action_pressed("ui_page_down", allow_echo):
			_prev_input()
		elif event.is_action_pressed("ui_page_up", allow_echo):
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
