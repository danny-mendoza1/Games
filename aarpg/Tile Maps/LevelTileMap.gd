class_name LevelTileMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())
	pass # Replace with function body.


#func get_tilemap_bounds() -> Array[Vector2]:
	#var bounds : Array[Vector2] = []
	#bounds.append(
		#Vector2(get_used_rect().position * rendering_quadrant_size)
	#)
	#bounds.append(
		#Vector2(get_used_rect().end * rendering_quadrant_size)
	#)
	#return bounds
func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	var used_rect = get_used_rect()
	print("Used rect pos:", used_rect.position, " end:", used_rect.end)
	
	bounds.append(Vector2(used_rect.position * rendering_quadrant_size))
	bounds.append(Vector2(used_rect.end * rendering_quadrant_size))
	
	print("Computed tilemap bounds:", bounds)
	return bounds
