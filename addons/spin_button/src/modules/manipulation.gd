@tool
extends RefCounted

const NONE_SELECTED := SBSpinButton.NONE_SELECTED

## The list of items.
var list: Array[String] = []

## The index of the currently selected item, or -1 if no item is selected.
var active_index: int = NONE_SELECTED:
	set = _set_active_index


## Add new items to the end.
## Items could be new item or array with such items.
func append_item(items) -> void:
	if items is Array:
		list.append_array(items)
	else:
		list.append(items)


## Add new items to the beginning.
## Items could be new item or array with such items.
func prepend_item(items) -> void:
	var new_active_index := active_index + 1

	if items is Array:
		items.reverse()
		for item in items:
			list.push_front(item)

		new_active_index += items.size() - 1
	else:
		list.push_front(items)

	active_index = new_active_index


## Add new items to the required index.
## Items could be new item or array with such items.
func add_item(idx: int, items) -> void:
	var base_length := list.size()
	var new_active_index := active_index

	if idx <= 0:
		prepend_item(items)
		return

	if idx >= base_length:
		append_item(items)
		return

	if active_index >= idx:
		new_active_index += 1

	var items_buffer: Array = []
	for i in range(idx, base_length):
		var current_slide = list.pop_back()
		items_buffer.push_front(current_slide)

	if items is Array:
		list.append_array(items)
		if range(items.size()).has(idx):
			new_active_index += items.size() - 1
		else:
			new_active_index = active_index
	else:
		list.append(items)

	list.append_array(items_buffer)
	active_index = new_active_index


## Remove all items.
func remove_all_items() -> void:
	var items_indexes = range(list.size())
	remove_item(items_indexes)


## Remove selected items.
## items_indexes could be a number with item index to remove or array with indexes.
func remove_item(items_indexes) -> void:
	if items_indexes is Array:
		items_indexes.sort()
		items_indexes.reverse()
		for index_to_remove in items_indexes:
			if range(list.size()).has(index_to_remove):
				if index_to_remove <= active_index:
					active_index -= 1
				list.remove_at(index_to_remove)
	else:
		if range(list.size()).has(items_indexes):
			if items_indexes <= active_index:
				active_index -= 1
			list.remove_at(items_indexes)


func _set_active_index(value: int) -> void:
	if value == active_index:
		return

	var items_count := list.size() - 1
	if value <= NONE_SELECTED:
		active_index = NONE_SELECTED
	elif value >= items_count:
		active_index = items_count
	else:
		active_index = value
