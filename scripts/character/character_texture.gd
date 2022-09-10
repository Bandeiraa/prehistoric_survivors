extends Sprite
class_name CharacterTexture

onready var animation: AnimationPlayer = get_node("%Animation")

var type_list: Array

var on_action: bool = false

export(String) var type_1
export(String) var type_2

export(float) var sprite_position_offset

func _ready() -> void:
	randomize()
	define_character_texture()
	position.x = sprite_position_offset
	
	
func define_character_texture() -> void:
	type_list = [type_1, type_2]
	var random_index: int = randi() % type_list.size()
	texture = load(type_list[random_index])
	
	
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
