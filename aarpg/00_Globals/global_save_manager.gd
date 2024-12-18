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
	print("save game")
	pass

func load_game() -> void:
	print("load game")
	pass
