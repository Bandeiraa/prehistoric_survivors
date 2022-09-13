extends KinematicBody2D
class_name Character, "res://assets/icons/character.svg"

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

onready var spell_manager: Node = get_node("SpellManager")
onready var spell_spawn_position: Position2D = get_node("SpellSpawnPosition")

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	set_physics_process(false)
	
	
func fade_out() -> void:
	animation.play("fade_out")
	
	
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
	var attack_condition: bool = (
		Input.is_action_just_pressed("ui_attack") and
		spell_manager.initial_spell.can_attack and
		not sprite.on_action
	)
	
	if attack_condition:
		sprite.action_behavior("attack")
		
	if Input.is_action_just_pressed("ui_dash") and not sprite.on_action:
		sprite.action_behavior("dash")
		stats.start_dash_timer()
		
		
func spawn_projectile() -> void:
	spell_manager.initial_spell.spawn_spell()
	
	
func update_health(damage: int) -> void:
	set_physics_process(false)
	if stats.health == 0:
		return
		
	stats.health = clamp(stats.health - damage, 0, stats.max_health)
	if stats.health == 0:
		sprite.action_behavior("death")
		return
		
	sprite.action_behavior("hit")
