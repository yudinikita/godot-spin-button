## A themed spin button that contain button.
@tool
@icon("res://addons/spin_button/assets/icons/sb_button.png")
class_name SBCustomButton
extends SBButton

## The button's text that will be displayed inside the value button's area.
@export var value_text: String = "":
	set = set_value_text,
	get = get_value_text


func _custom_init() -> void:
	_custom_properties()


func _custom_initialize() -> void:
	value_button.show()
	value_text_container.show()


func _custom_properties() -> void:
	value_button.flat = false


## Sets the button text that will be displayed inside the value button's area.
func set_value_text(value: String) -> void:
	value_text = value
	value_text_label.text = value


## Gets the button text.
func get_value_text() -> String:
	return value_text
