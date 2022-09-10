extends KinematicBody2D
class_name Character, "res://assets/icons/character.svg"

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move_behavior()
	sprite.animate(velocity)
	
	
func move_behavior() -> void:
	velocity = get_direction() * stats.move_speed
	velocity = move_and_slide(velocity)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
