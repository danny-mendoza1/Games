class_name InventoryData extends Resource

@export var slots: Array[SlotData]


func _init() -> void:
	connect_slots()
	pass
	



func add_item(item: ItemData, count: int = 1) -> bool:
	for slot in slots:
		if slot:
			#pick up a potion with a potion in your inventory
			if slot.item_data == item:
				slot.quantity += count
				return true
				
	for index in slots.size():
		# adding an item when you don't have one
		if slots[index] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[index] = new
			new.changed.connect(slot_changed)
			return true
	print("inventory was full")
	return false

func connect_slots() -> void:
	for slot in slots:
		if slot:
			slot.changed.connect(slot_changed)
			
func slot_changed() -> void:
	for slot in slots:
		if slot:
			if slot.quantity < 1:
				slot.changed.disconnect(slot_changed)
				var index = slots.find(slot)
				slots[index] = null
				emit_changed()
	pass
	
