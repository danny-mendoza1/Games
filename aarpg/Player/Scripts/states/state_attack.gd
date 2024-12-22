class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0


@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var walk : State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var attack: State = $"."
@onready var hurt_box: HurtBox = $"../../Sprite2D/AttackHurtBox"




func enter() -> void:
	player.update_animation("attack")
	attack_animation.play("attack_" + player.animation_direction())
	animation_player.animation_finished.connect( end_attack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	
	## create delay between attack and actual attack
	await get_tree().create_timer(0.075).timeout
	if attacking:
		hurt_box.monitoring = true
	pass

func exit() -> void:
	animation_player.animation_finished.disconnect( end_attack )
	attacking = false
	hurt_box.monitoring = false
	pass
	
## What happens during the _process update in this State
func process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

## What happens during the _physics_process update in this State
func physics( _delta : float ) -> State:
	return null

## What happens with input envents in this State
func handle_input ( _event : InputEvent ) -> State:
	return null

func end_attack( _newAnimationName : String ) -> void:
	attacking = false