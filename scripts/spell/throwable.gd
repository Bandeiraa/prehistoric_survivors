extends Area2D
class_name Throwable

onready var sprite: Sprite = get_node("Texture")

var direction: Vector2

var max_health: int
var rotation_direction: int

var already_killed: bool = false

export(int) var damage

export(int) var health
export(int) var move_speed
export(int) var rotation_speed

func _ready() -> void:
	max_health = health
	rotation_direction = int(sign(direction.x))
	
	
func _process(delta: float) -> void:
	translate(direction * delta * move_speed)
	rotation_degrees += rotation_direction * rotation_speed * delta
	
	
func on_throwable_area_entered(area) -> void:
	health = clamp(health - 1, 0, max_health)
	area.get_parent().update_health(damage)
	if health == 0:
		kill()
		
		
func on_notifier_screen_exited() -> void:
	if already_killed:
		return
		
	kill()
	
	
func kill() -> void:
	already_killed = true
	queue_free()
