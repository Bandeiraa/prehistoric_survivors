extends Node
class_name CharacterStats

onready var dash_timer: Timer = get_node("DashTimer")

var health: int
var max_health: int

var on_dash: bool = false

export(float) var dash_duration

export(int, 90, 150, 5) var base_move_speed = 90
export(int, 300, 450, 5) var base_dash_speed = 300

export(int, 5, 30, 5) var base_attack = 5
export(int, 15, 45, 5) var base_health = 15

func _ready() -> void:
	health = base_health
	max_health = base_health
	
	
func start_dash_timer() -> void:
	on_dash = true
	dash_timer.start(dash_duration)
	
	
func on_dash_timer_timeout() -> void:
	on_dash = false
