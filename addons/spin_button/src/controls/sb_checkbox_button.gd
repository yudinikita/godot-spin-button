## A button that represents a binary choice.
@tool
@icon("res://addons/spin_button/assets/icons/sb_checkbox.png")
class_name SBCheckboxButton
extends SBButton

## Emitted when the CheckboxSpinButton is checked or unchecked.
signal changed(checked: bool)

## If [code]true[/code], the Checkbox is checked.
@export var checked: bool:
	set = set_checked,
	get = get_checked

## The button's text that will be displayed inside the value button's area.
@export_multiline var value_text: String = "":
	set = _set_value_text

## The icon to display when the CheckboxSpinButton is checked.
@export var checked_icon: Texture2D:
	set = _set_checked_icon

## The icon to display when the CheckboxSpinButton is unchecked.
@export var unchecked_icon: Texture2D:
	set = _set_unchecked_icon,
	get = _get_unchecked_icon

## Alignment of the checked icon.
@export_enum("Left:0", "Center:1", "Right:2")
var checked_icon_alignment: int = HORIZONTAL_ALIGNMENT_RIGHT:
	set = _set_checked_icon_alignment

@onready
var _checked_icon_default := preload("res://addons/spin_button/assets/default_icons/checked.png")
@onready var _unchecked_icon_default := preload(
	"res://addons/spin_button/assets/default_icons/unchecked.png"
)


func _custom_initialize() -> void:
	value_button.show()
	value_text_container.show()
	content_button.icon_alignment = checked_icon_alignment
	_change_icons()
	_setup_signals()


## Sets the checked state.
func set_checked(value: bool) -> void:
	checked = value
	emit_signal("changed", checked)
	if _is_initialized:
		_change_icons()


## Returns the checked state.
func get_checked() -> bool:
	return checked


func _setup_signals() -> void:
	pressed.connect(Callable(self, "_on_button_pressed"))
	value_button.pressed.connect(Callable(self, "_on_button_pressed"))


func _set_checked_icon(value: Texture2D) -> void:
	checked_icon = value
	if _is_initialized:
		_change_icons()


func _set_unchecked_icon(value: Texture2D) -> void:
	unchecked_icon = value
	if _is_initialized:
		_change_icons()


func _get_unchecked_icon() -> Texture2D:
	return unchecked_icon


func _set_checked_icon_alignment(value: int) -> void:
	checked_icon_alignment = value
	content_button.icon_alignment = checked_icon_alignment


func _set_value_text(value: String) -> void:
	value_text = value
	value_text_label.text = value


func _change_icons() -> void:
	if checked:
		content_button.icon = checked_icon if checked_icon else _checked_icon_default
	else:
		content_button.icon = unchecked_icon if unchecked_icon else _unchecked_icon_default


func _on_button_pressed() -> void:
	checked = not checked
