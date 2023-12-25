## A button that represents a binary choice.
@tool
@icon("res://addons/spin_button/assets/icons/sb_check.png")
class_name SBCheckButton
extends SBButton

## Emitted when a button is toggled.
signal button_toggled(text_button: String, toggled_on: bool)

const BUTTONS_CONTAINER_NAME := "ButtonsContainer"
const BUTTONS_COUNT := 2

## The button's text that will be displayed inside the value button's area.
@export var buttons_text: Array[String] = []:
	set = _set_buttons_text

## The number of buttons.
@export var buttons_count: int = BUTTONS_COUNT:
	set = _set_buttons_count

## If [code]true[/code], multiple buttons can be toggled.
@export var multiple_select: bool:
	set = _set_multiple_select

## If [code]true[/code], it is possible to unpress all buttons.
@export var allow_unpress: bool:
	set = _set_allow_unpress

## The check button's theme.
@export var check_button_theme: Theme:
	set = _set_check_button_theme

## Container for the check buttons.
var buttons_container: HBoxContainer

## All the check buttons.
var buttons: Array[Button] = []

var _button_group: ButtonGroup = ButtonGroup.new()


func _custom_init() -> void:
	_init_buttons_container()


func _custom_initialize() -> void:
	_add_buttons_container()
	_update_buttons()
	_update_multiple_select()
	_button_group.allow_unpress = allow_unpress


func get_button(idx: int) -> Button:
	if idx < 0 or idx >= buttons_count:
		return null

	return buttons[idx]


func _set_buttons_text(value: Array[String]) -> void:
	buttons_text = value
	if _is_initialized:
		buttons_count = value.size()
		for i in range(buttons_count):
			buttons[i].text = value[i]


func _set_buttons_count(value: int) -> void:
	buttons_count = value

	if _is_initialized:
		_update_buttons()


func _set_multiple_select(value: bool) -> void:
	multiple_select = value

	if _is_initialized:
		_update_multiple_select()


func _set_allow_unpress(value: bool) -> void:
	allow_unpress = value

	if _is_initialized:
		_button_group.allow_unpress = allow_unpress


func _set_check_button_theme(value: Theme) -> void:
	check_button_theme = value

	if _is_initialized:
		for btn in buttons:
			btn.theme = check_button_theme


func _init_buttons_container() -> void:
	buttons_container = HBoxContainer.new()
	buttons_container.name = BUTTONS_CONTAINER_NAME


func _add_buttons_container() -> void:
	value_wrapper.add_child(buttons_container)


func _update_buttons() -> void:
	_remove_all_buttons()
	buttons_text.resize(buttons_count)
	for i in range(buttons_count):
		var btn = _add_check_button()
		if i < buttons_text.size():
			btn.text = buttons_text[i]


func _update_multiple_select() -> void:
	if multiple_select:
		for btn in buttons:
			btn.button_group = null
	else:
		for btn in buttons:
			btn.button_group = _button_group


func _add_check_button(text_button: String = "") -> Button:
	var btn = Button.new()
	_init_check_button(btn)
	btn.text = text_button
	btn.toggled.connect(Callable(self, "_on_button_toggled").bind(btn))
	buttons_container.add_child(btn)
	buttons.append(btn)
	return btn


func _init_check_button(btn: Button) -> void:
	btn.toggle_mode = true
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	btn.theme = check_button_theme
	btn.button_group = _button_group


func _remove_all_buttons() -> void:
	for btn in buttons:
		btn.free()
	buttons.clear()


func _on_button_toggled(toggled_on: bool, btn: Button) -> void:
	if multiple_select:
		emit_signal("button_toggled", btn.text, toggled_on)
	else:
		if toggled_on:
			emit_signal("button_toggled", btn.text, toggled_on)
