extends KinematicBody2D
class_name Character, "res://assets/icons/character.svg"

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move_behavior()
	action_behavior()
	sprite.animate(velocity)
	
	
func move_behavior() -> void:
	if stats.on_dash:
		velocity = get_direction() * stats.base_dash_speed
		velocity = move_and_slide(velocity)
		return
		
	velocity = get_direction() * stats.base_move_speed
	velocity = move_and_slide(velocity)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	
func action_behavior() -> void:
	if Input.is_action_just_pressed("ui_attack") and not sprite.on_action:
		sprite.action_behavior("attack")
		
	if Input.is_action_just_pressed("ui_dash") and not sprite.on_action:
		sprite.action_behavior("dash")
		stats.start_dash_timer()
