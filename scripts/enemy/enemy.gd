extends KinematicBody2D
class_name Enemy

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

onready var attack_timer: Timer = get_node("AttackTimer")

var max_health: int
var velocity: Vector2
var can_attack: bool = true

export(int) var health

export(int) var damage
export(int) var move_speed
export(int) var distance_threshold

export(float) var attack_cooldown

func _ready() -> void:
	max_health = health
	
	
func _physics_process(_delta: float) -> void:
	if not is_instance_valid(global_data.character):
		return
		
	move()
	velocity = move_and_slide(velocity)
	
	
func move() -> void:
	var direction: Vector2 = global_data.character.global_position - global_position
	var distance: float = direction.length()
	if distance < distance_threshold and can_attack:
		global_data.character.update_health(damage)
		attack_timer.start(attack_cooldown)
		velocity = Vector2.ZERO
		can_attack = false
		
	if distance > distance_threshold:
		velocity = direction.normalized() * move_speed
		
		
func update_health(value: int) -> void:
	set_physics_process(false)
	if health == 0:
		return
		
	health = clamp(health - value, 0, max_health)
	if health == 0:
		animation.play("death")
		return
		
	animation.play("hit")
	
	
func on_attack_timer_timeout() -> void:
	can_attack = true
	
	
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "hit":
		animation.play("walk")
		set_physics_process(true)
		
	if anim_name == "death":
		queue_free()
