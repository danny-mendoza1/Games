extends CanvasLayer


var hearts: Array[HeartGUI] = []


func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	pass 



func update_hp(_hp: int, _max_hp: int) -> void:
	update_max_hp(_max_hp)
	for index in _max_hp:
		update_heart(index, _hp)
	pass

func update_heart(_index: int, _hp: int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0 ,2)
	hearts[_index].value = _value
	pass
	
func update_max_hp( _max_hp: int) -> void:
	var _heart_count: int = round(_max_hp * 0.5)
	for index in hearts.size():
		if index < _heart_count:
			hearts[index].visible = true
		else:
			hearts[index].visible = false
	pass
