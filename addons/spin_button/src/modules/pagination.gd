@tool
extends RefCounted

## Emitted when a bullet is selected.
signal bullet_selected(idx: int)

const NONE_SELECTED := -1
const WRAPPER_NAME := "BulletsWrapper"
const CONTAINER_NAME := "BulletsContainer"
const BULLET_NAME := "Bullet"
const BULLET_TYPE := "panel"

## Set the pagination to enabled or disabled.
var enabled: bool = true:
	set = _set_enabled

## Set the number of bullets.
var bullet_count: int = 0:
	set = set_bullet_count,
	get = get_bullet_count

## Set the index of the currently selected bullet.
var current: int = NONE_SELECTED:
	set = select

## Set whether the bullets are clickable.
var clickable: bool:
	set = _set_clickable

## Sets whether bullets will fill all available space.
var fill_bullets: bool:
	set = _set_fill_bullets

## Sets whether bullets are displayed while the button is in focus.
var focus_bullets: bool:
	set = _set_focus_bullets

## Sets the size of the bullets.
var bullet_size := Vector2(4, 4):
	set = _set_bullet_size

## Sets the separation between the bullets.
var bullet_separation := 4:
	set = _set_bullet_separation

## Sets the separation between the bullets and the bottom border.
var bullet_margin: int:
	set = _set_bullet_margin

## Sets the style of the active bullet.
var bullet_style: StyleBox:
	set = _set_bullet_style

## Sets the style of the inactive bullets.
var bullet_inactive_style: StyleBox:
	set = _set_bullet_inactive_stylee

## Sets the style of the hovered active bullet.
var bullet_hover: StyleBox:
	set = _set_bullet_hover

## Sets the style of the hovered inactive bullets.
var bullet_inactive_hover: StyleBox:
	set = _set_bullet_inactive_hover

## Array of bullets.
var bullets: Array[Node] = []

## Wrapper for bullets.
var wrapper: MarginContainer

## Container for bullets.
var container: HBoxContainer

var _owner: SBSpinButton
var _initialized: bool


## Initializes the pagination.
func initialize(spin_button: SBSpinButton) -> void:
	if _initialized:
		return

	_owner = spin_button
	_init_wrapper()
	_init_container()
	bullet_count = _owner.get_item_count()
	_add_containers()
	_connect_signals()
	_initialized = true


## Disable pagination.
func disable() -> void:
	enabled = false


## Enable pagination.
func enable() -> void:
	enabled = true


## Select a bullet.
func select(idx: int) -> void:
	if idx == current:
		return

	_reset_bullets_theme()

	if idx == NONE_SELECTED:
		current = NONE_SELECTED
	else:
		if idx < bullets.size():
			_set_bullet_theme(bullets[idx], bullet_style)
			current = idx

	emit_signal("bullet_selected", idx)


## Set the number of bullets.
func set_bullet_count(value: int) -> void:
	if value < 0:
		value = 0

	var prev_size := bullets.size()

	if value == prev_size:
		return

	if prev_size > value:
		for i in range(value, prev_size):
			bullets[i].free()

	bullets.resize(value)

	if value > prev_size:
		for i in range(prev_size, value):
			bullets[i] = _new_bullet(i)
			container.add_child(bullets[i])

	_update_active_bullet()


## Get the number of bullets.
func get_bullet_count() -> int:
	return bullets.size()


func _set_enabled(value: bool) -> void:
	if wrapper:
		wrapper.visible = value and not focus_bullets
		_update_active_bullet()
	enabled = value


func _set_clickable(value: bool) -> void:
	clickable = value
	_update_bullets_clickable()


func _set_fill_bullets(value: bool) -> void:
	fill_bullets = value
	_update_bullets_width()


func _set_focus_bullets(value: bool) -> void:
	focus_bullets = value
	if wrapper and enabled:
		wrapper.visible = not value


func _set_bullet_size(value: Vector2) -> void:
	bullet_size = value
	_update_bullets_size()


func _set_bullet_separation(value: int) -> void:
	bullet_separation = value
	if container:
		container.add_theme_constant_override("separation", value)


func _set_bullet_margin(value: int) -> void:
	bullet_margin = value
	if wrapper:
		wrapper.add_theme_constant_override("margin_bottom", value)


func _set_bullet_style(value: StyleBox) -> void:
	bullet_style = value
	if current != NONE_SELECTED:
		_set_bullet_theme(bullets[current], value)
		_update_active_bullet()


func _set_bullet_inactive_stylee(value: StyleBox) -> void:
	bullet_inactive_style = value
	_reset_bullets_theme()
	_update_active_bullet()


func _set_bullet_hover(value: StyleBox) -> void:
	bullet_hover = value


func _set_bullet_inactive_hover(value: StyleBox) -> void:
	bullet_inactive_hover = value


func _init_wrapper() -> void:
	wrapper = MarginContainer.new()
	wrapper.name = WRAPPER_NAME
	wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE
	wrapper.set_anchors_preset(Control.PRESET_FULL_RECT)
	wrapper.visible = enabled and not focus_bullets
	wrapper.add_theme_constant_override("margin_bottom", bullet_margin)


func _init_container() -> void:
	container = HBoxContainer.new()
	container.name = CONTAINER_NAME
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.size_flags_vertical = Control.SIZE_SHRINK_END
	container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	container.add_theme_constant_override("separation", bullet_separation)


func _add_containers() -> void:
	wrapper.add_child(container)
	_owner.value_button.add_child(wrapper)


func _connect_signals() -> void:
	_owner.item_selected.connect(Callable(self, "_on_item_selected"))
	_owner.length_changed.connect(Callable(self, "_on_length_changed"))
	_owner.focus_entered.connect(Callable(self, "_on_owner_focus_entered"))
	_owner.focus_exited.connect(Callable(self, "_on_owner_focus_exited"))


func _new_bullet(id: int) -> Panel:
	var bullet := Panel.new()
	bullet.name = BULLET_NAME + "@" + str(id)
	bullet.custom_minimum_size = bullet_size
	bullet.mouse_entered.connect(Callable(self, "_on_bullet_mouse_entered").bind(id))
	bullet.mouse_exited.connect(Callable(self, "_on_bullet_mouse_exited").bind(id))
	bullet.gui_input.connect(Callable(self, "_on_bullet_input").bind(id))
	if bullet_style:
		_set_bullet_theme(bullet, bullet_style)
	if fill_bullets:
		bullet.custom_minimum_size = Vector2(0, bullet_size.y)
		bullet.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if not clickable:
		bullet.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return bullet


func _set_bullet_theme(bullet: Panel, new_theme: StyleBox = null) -> void:
	if new_theme:
		bullet.add_theme_stylebox_override(BULLET_TYPE, new_theme)
	else:
		bullet.remove_theme_stylebox_override(BULLET_TYPE)


func _update_active_bullet() -> void:
	_reset_bullets_theme()

	if current == NONE_SELECTED:
		return

	_set_bullet_theme(bullets[current], bullet_style)


func _update_bullets_clickable() -> void:
	for bullet in bullets:
		if clickable:
			bullet.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			bullet.mouse_filter = Control.MOUSE_FILTER_PASS


func _update_bullets_width() -> void:
	for bullet in bullets:
		if fill_bullets:
			bullet.custom_minimum_size = Vector2(0, bullet_size.y)
			bullet.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		else:
			bullet.custom_minimum_size = Vector2(bullet_size.x, bullet_size.y)
			bullet.size_flags_horizontal = Control.SIZE_FILL


func _update_bullets_size() -> void:
	for bullet in bullets:
		bullet.custom_minimum_size = bullet_size


func _reset_bullets_theme() -> void:
	for bullet in bullets:
		_set_bullet_theme(bullet, bullet_inactive_style)


func _on_item_selected(idx: int) -> void:
	select(idx)


func _on_length_changed(length: int) -> void:
	set_bullet_count(length)


func _on_bullet_mouse_entered(id: int) -> void:
	if clickable and bullet_hover and bullet_inactive_hover:
		if id == current:
			_set_bullet_theme(bullets[id], bullet_hover)
		else:
			_set_bullet_theme(bullets[id], bullet_inactive_hover)


func _on_bullet_mouse_exited(id: int) -> void:
	if clickable and bullet_hover and bullet_inactive_hover:
		if id == current:
			_set_bullet_theme(bullets[id], bullet_style)
		else:
			_set_bullet_theme(bullets[id], bullet_inactive_style)


func _on_bullet_input(event: InputEvent, id: int) -> void:
	if clickable:
		if (
			event is InputEventMouseButton
			and event.pressed
			and event.button_index == MOUSE_BUTTON_LEFT
		):
			_owner.select(id)


func _on_owner_focus_entered() -> void:
	if enabled and focus_bullets:
		wrapper.show()


func _on_owner_focus_exited() -> void:
	if enabled and focus_bullets:
		wrapper.hide()
