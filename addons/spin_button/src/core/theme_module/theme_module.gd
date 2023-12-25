@tool
extends "res://addons/spin_button/src/core/theme_module/base_theme_module.gd"


func _init() -> void:
	_valid_theme_types = PackedStringArray()


func initialize(owner: SBBaseButton) -> void:
	_owner = owner
	_connect_signals()
	_initialize_controls()
	apply_theme()


func apply_theme() -> void:
	_valid_theme_types.clear()
	_initialize_valid_theme_types()

	if not _theme or _valid_theme_types.is_empty():
		return

	_initialize_state()


func change_state(new_state: ButtonState) -> void:
	if not _theme or _valid_theme_types.is_empty():
		return
	_apply_state_overrides(new_state)


func reset_theme() -> void:
	if not _theme or _valid_theme_types.is_empty():
		return
	_remove_theme_overrides()
	_valid_theme_types.clear()


func _initialize_state() -> void:
	_remove_theme_overrides()
	change_state(ButtonState.INIT)
	change_state(ButtonState.NORMAL)
	if _owner.disabled:
		change_state(ButtonState.DISABLED)


func _remove_theme_overrides() -> void:
	for type_name in _valid_theme_types:
		match type_name:
			C_WRAPPER:
				_remove_theme_margin_container(type_name)
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_remove_theme_label(type_name)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_remove_theme_button(type_name)
			C_SLIDER:
				_remove_theme_slider(type_name)


func _apply_state_overrides(new_state: ButtonState) -> void:
	match new_state:
		ButtonState.INIT:
			_apply_init_state_overrides()
		ButtonState.NORMAL:
			_apply_normal_state_overrides()
		ButtonState.DISABLED:
			_apply_disabled_state_overrides()
		ButtonState.HOVER:
			_apply_hover_state_overrides()
		ButtonState.FOCUS:
			_apply_focus_state_overrides()
		ButtonState.PRESSED:
			_apply_pressed_state_overrides()


func _apply_init_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_WRAPPER:
				_apply_init_margin_container(valid_type)
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_init_label(valid_type)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_apply_init_button(valid_type)
			C_SLIDER:
				_apply_init_slider(valid_type)


func _apply_normal_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_normal_label(valid_type)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_apply_normal_button(valid_type)
			C_SLIDER:
				_apply_normal_slider(valid_type)


func _apply_disabled_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_disabled_label(valid_type)
			C_SLIDER:
				_apply_disabled_slider(valid_type)


func _apply_hover_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_hover_label(valid_type)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_apply_hover_button(valid_type)
			C_SLIDER:
				_apply_hover_slider(valid_type)


func _apply_focus_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_focus_label(valid_type)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_apply_focus_button(valid_type)
			C_SLIDER:
				_apply_focus_slider(valid_type)


func _apply_pressed_state_overrides() -> void:
	for valid_type in _valid_theme_types:
		match valid_type:
			C_TITLE, C_DESCRIPTION, C_VALUE, C_SLIDER_VALUE, C_SLIDER_TOOLTIP:
				_apply_pressed_label(valid_type)
			C_LEFT_ICON, C_RIGHT_ICON, C_PREV_NAV, C_NEXT_NAV, C_CONTENT:
				_apply_pressed_button(valid_type)
			C_SLIDER:
				_apply_pressed_slider(valid_type)


func _connect_signals() -> void:
	_owner.mouse_entered.connect(Callable(self, "_on_owner_mouse_entered"))
	_owner.mouse_exited.connect(Callable(self, "_on_owner_mouse_exited"))
	_owner.focus_entered.connect(Callable(self, "_on_owner_focus_entered"))
	_owner.focus_exited.connect(Callable(self, "_on_owner_focus_exited"))
	_owner.button_down.connect(Callable(self, "_on_owner_button_down"))
	_owner.button_up.connect(Callable(self, "_on_owner_button_up"))
	_owner.button_disabled.connect(Callable(self, "_on_owner_button_disabled"))
	_owner.button_enabled.connect(Callable(self, "_on_owner_button_enabled"))


func _on_owner_button_disabled() -> void:
	change_state(ButtonState.DISABLED)


func _on_owner_button_enabled() -> void:
	change_state(ButtonState.NORMAL)
	if _owner.is_hovered():
		change_state(ButtonState.HOVER)
	elif _owner.has_focus():
		change_state(ButtonState.FOCUS)


func _on_owner_mouse_entered() -> void:
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	else:
		change_state(ButtonState.HOVER)


func _on_owner_mouse_exited() -> void:
	change_state(ButtonState.NORMAL)
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	elif _owner.has_focus():
		change_state(ButtonState.FOCUS)


func _on_owner_focus_entered() -> void:
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	else:
		change_state(ButtonState.FOCUS)


func _on_owner_focus_exited() -> void:
	change_state(ButtonState.NORMAL)
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	elif _owner.is_hovered():
		change_state(ButtonState.HOVER)


func _on_owner_button_down() -> void:
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	else:
		change_state(ButtonState.PRESSED)


func _on_owner_button_up() -> void:
	change_state(ButtonState.NORMAL)
	if _owner.disabled:
		change_state(ButtonState.DISABLED)
	elif _owner.is_hovered():
		change_state(ButtonState.HOVER)
	elif _owner.has_focus():
		change_state(ButtonState.FOCUS)
