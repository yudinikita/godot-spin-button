extends Control

const GITHUB_LINK := "https://github.com/nblackninja/godot-spin-button"

var sb_manip: SBSpinButton
var te_idx: TextEdit
var te_item: TextEdit


func _ready():
	sb_manip = find_child("ManipulationSBSpinButton")
	te_idx = find_child("IdTextEdit")
	te_item = find_child("ItemTextEdit")


func _on_github_button_pressed():
	OS.shell_open(GITHUB_LINK)


func _on_append_button_pressed():
	sb_manip.append_item(te_item.text)


func _on_prepend_button_pressed():
	sb_manip.prepend_item(te_item.text)


func _on_add_button_pressed():
	sb_manip.add_item(te_item.text, te_idx.text.to_int())


func _on_remove_button_pressed():
	sb_manip.remove_item(te_idx.text.to_int())


func _on_remove_all_button_pressed():
	sb_manip.remove_all_items()
