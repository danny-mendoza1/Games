class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://GUI/pause_menu/inventory/inventory_slot.tscn")

var focus_index: int = 0

@export var data: InventoryData


func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	data.changed.connect(on_inventory_changed)
	pass

func clear_inventory() -> void:
	for child in get_children():
		child.queue_free()
		
func update_inventory(i: int = 0) -> void:
	for slot in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = slot
		new_slot.focus_entered.connect(item_focused)
		
	await get_tree().process_frame
	get_child(i).grab_focus()

func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
			return
	pass

func on_inventory_changed() -> void:
	var i = focus_index
	clear_inventory()
	update_inventory(i)
