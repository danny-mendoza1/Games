extends Node

const SAVE_PATH = "user://"


signal game_loaded
signal game_saved


var current_save: Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		position_x = 0,
		position_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
	
}


func save_game() -> void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse( file.get_line() )
	var save_dictionary : Dictionary  = json.get_data() as Dictionary
	current_save = save_dictionary
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position( Vector2(current_save.player.position_x, current_save.player.position_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()
	
	pass


func update_player_data() -> void:
	var p: Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.position_x = p.global_position.x
	current_save.player.position_y = p.global_position.y

func update_scene_path() -> void:
	var p: String = ""
	for child in get_tree().root.get_children():
		if child is Level:
			p = child.scene_file_path
	current_save.scene_path = p
	
