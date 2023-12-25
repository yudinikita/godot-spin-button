## A button that represents a link.
@tool
@icon("res://addons/spin_button/assets/icons/sb_link.png")
class_name SBLinkButton
extends SBButton

## The button's text that will be displayed inside the value button's area.
@export_multiline var link_text: String = "":
	set = set_link_text,
	get = get_link_text

## The URI for this SBLinkButton.
## If set to a valid URI, pressing the button opens the URI using the operating system's
## default program for the protocol (via OS.shell_open).
## HTTP and HTTPS URLs open the default web browser.
@export var uri: String:
	set = set_uri,
	get = get_uri

## The alignment of the link text.
@export_enum("Left:0", "Center:4", "Right:8") var link_alignment: int = Control.SIZE_SHRINK_CENTER:
	set = _set_link_alignment


func _custom_initialize() -> void:
	value_button.show()
	value_text_container.show()
	_setup_signals()


func _setup_signals() -> void:
	pressed.connect(Callable(self, "_on_link_pressed"))
	value_button.pressed.connect(Callable(self, "_on_link_pressed"))


## Sets the link text.
func set_link_text(value: String) -> void:
	link_text = value

	if value_text_label:
		value_text_label.text = value


## Returns the link text.
func get_link_text() -> String:
	return link_text


## Sets the URI.
func set_uri(value: String) -> void:
	uri = value


## Returns the URI.
func get_uri() -> String:
	return uri


## Opens the URI using the operating system's default program for the protocol (via OS.shell_open).
## HTTP and HTTPS URLs open the default web browser.
func open_uri() -> void:
	OS.shell_open(uri)


func _set_link_alignment(value: Control.SizeFlags) -> void:
	link_alignment = value
	value_text_label.size_flags_horizontal = value


func _on_link_pressed() -> void:
	open_uri()
