extends Node
## WebBridge: Handles communication between Godot and the browser window
## Sends game events to the parent website for UI reactions

var is_web: bool = false

func _ready() -> void:
	# Check if running in a web browser
	is_web = OS.has_feature('web')
	
	if is_web:
		print("[WebBridge] Running in web browser - JavaScript bridge active")
	else:
		print("[WebBridge] Running natively - JavaScript bridge inactive")
	
	# Wait for player to spawn before connecting signals
	_connect_player_signals()


func _connect_player_signals() -> void:
	# Wait until the player is spawned
	if not PlayerManager.player_spawned:
		await get_tree().create_timer(0.3).timeout
	
	# Double-check player exists
	if PlayerManager.player == null:
		push_error("[WebBridge] Failed to connect - Player is null")
		return
	
	# Connect to player damage signal
	PlayerManager.player.player_damaged.connect(_on_player_damaged)
	print("[WebBridge] Connected to player_damaged signal")


func _on_player_damaged(hurt_box: HurtBox) -> void:
	# Get current player health
	var current_hp = PlayerManager.player.hp
	var max_hp = PlayerManager.player.max_hp
	
	# Send damage event to browser
	send_game_event("damage", {
		"hp": current_hp,
		"max_hp": max_hp,
		"damage": hurt_box.damage
	})


## Sends a game event to the browser window
## @param event_name: The name of the event (e.g., "damage", "levelup", "death")
## @param data: Optional dictionary of data to send with the event
func send_game_event(event_name: String, data: Dictionary = {}) -> void:
	if not is_web:
		return
	
	# Convert data dictionary to JSON string
	var json_data = JSON.stringify(data)
	
	# Build JavaScript code to dispatch the event
	var js_code = "window.dispatchGameEvent('%s', %s)" % [event_name, json_data]
	
	# Execute JavaScript in the browser
	JavaScriptBridge.eval(js_code, true)
	
	print("[WebBridge] Sent event '%s' with data: %s" % [event_name, json_data])
