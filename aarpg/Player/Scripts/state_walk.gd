class_name State_Walk extends State

@export var move_speed:float = 100.0
@onready var idle : State = $"../Idle"
@onready var attack: State = $"../Attack"



func Enter() -> void:
	player.update_animation("walk")
	pass
	

func Exit() -> void:
	pass
	
## What happens during the _process update in this State
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
		
	return null

## What happens during the _physics_process update in this State
func Physics( _delta : float ) -> State:
	return null

## What happens with input envents in this State
func HandleInput ( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
