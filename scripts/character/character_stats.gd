extends Node
class_name CharacterStats

onready var dash_timer: Timer = get_node("DashTimer")

var on_dash: bool = false

export(float) var dash_duration

export(int, 90, 150, 5) var move_speed = 90
export(int, 300, 450, 10) var dash_speed = 300

func start_dash_timer() -> void:
	on_dash = true
	dash_timer.start(dash_duration)
	
	
func on_dash_timer_timeout() -> void:
	on_dash = false
