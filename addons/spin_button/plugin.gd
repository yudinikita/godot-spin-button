@tool
extends EditorPlugin

const ADDON_PATH := "res://addons/spin_button"
const CORE_PATH := ADDON_PATH + "/src/core/"
const CONTROLS_PATH := ADDON_PATH + "/src/controls/"
const ICON_PATH := ADDON_PATH + "/assets/icons/"

const BASE_TYPE := "SBButton"

const SB_BASE := "SBBaseButton"
const SB_BUTTON := "SBButton"
const SB_SPIN := "SBSpinButton"
const SB_CUSTOM := "SBCustomButton"
const SB_LINK := "SBLinkButton"
const SB_SLIDER := "SBSliderButton"
const SB_CHECKBOX := "SBCheckboxButton"
const SB_CHECK := "SBCheckButton"

const PREFIX := "sb_"
const SCRIPT_FORMAT := ".gd"
const ICON_FORMAT := ".png"


func _enter_tree():
	add_custom_type(
		SB_BASE,
		"Button",
		preload(CORE_PATH + PREFIX + "base_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "base" + ICON_FORMAT)
	)
	add_custom_type(
		SB_BUTTON,
		SB_BASE,
		preload(CORE_PATH + PREFIX + "button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "button" + ICON_FORMAT)
	)
	add_custom_type(
		SB_SPIN,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "spin_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "spin" + ICON_FORMAT)
	)
	add_custom_type(
		SB_CUSTOM,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "custom_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "custom" + ICON_FORMAT)
	)
	add_custom_type(
		SB_LINK,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "link_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "link" + ICON_FORMAT)
	)
	add_custom_type(
		SB_SLIDER,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "slider_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "slider" + ICON_FORMAT)
	)
	add_custom_type(
		SB_CHECKBOX,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "checkbox_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "checkbox" + ICON_FORMAT)
	)
	add_custom_type(
		SB_CHECK,
		BASE_TYPE,
		preload(CONTROLS_PATH + PREFIX + "check_button" + SCRIPT_FORMAT),
		preload(ICON_PATH + PREFIX + "check" + ICON_FORMAT)
	)


func _exit_tree():
	remove_custom_type(SB_BASE)
	remove_custom_type(SB_BUTTON)
	remove_custom_type(SB_SPIN)
	remove_custom_type(SB_CUSTOM)
	remove_custom_type(SB_LINK)
	remove_custom_type(SB_SLIDER)
	remove_custom_type(SB_CHECKBOX)
	remove_custom_type(SB_CHECK)
