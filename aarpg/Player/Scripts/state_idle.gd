class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack: State = $"../Attack"


func Enter() -> void:
	player.update_animation("idle")
	pass

func Exit() -> void:
	pass
	
## What happens during the _process update in this State
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

## What happens during the _physics_process update in this State
func Physics( _delta : float ) -> State:
	return null

## What happens with input envents in this State
func HandleInput ( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
