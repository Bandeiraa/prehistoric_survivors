extends Sprite
class_name CharacterTexture

onready var character: KinematicBody2D = get_parent()
onready var animation: AnimationPlayer = get_node("%Animation")

var type_list: Array

var on_action: bool = true

export(String) var type_1
export(String) var type_2

export(float) var sprite_position_offset

func _ready() -> void:
	define_character_texture()
	position.x = sprite_position_offset
	
	
func define_character_texture() -> void:
	type_list = [type_1, type_2]
	texture = load(type_list[global_data.skin_index])
	
	
func animate(velocity: Vector2) -> void:
	verify_direction(velocity.x)
	
	if on_action: 
		return
		
	move_behavior(velocity)
	
	
func verify_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		position.x = sprite_position_offset
		
	if direction < 0:
		flip_h = true
		position.x = -sprite_position_offset
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("walk")
		return
		
	animation.play("idle")
	
	
func action_behavior(action: String) -> void:
	on_action = true
	animation.play(action)
	
	
func on_animation_finished(anim_name) -> void:
	var action_state: bool = (
		anim_name == "fade_out" or
		anim_name == "attack" or
		anim_name == "dash"
	)
	
	if action_state:
		on_action = false
		character.set_physics_process(true)
