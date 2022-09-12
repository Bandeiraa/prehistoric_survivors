extends Node2D
class_name SpellManager

onready var spawn_timer: Timer = get_node("SpawnTimer")

var spell_dict: Dictionary = {}

export(PackedScene) var spell

export(int) var spawn_amount = 1
export(bool) var can_attack = true
export(float) var spawn_cooldown = 1.0

func spawn_spell() -> void:
	var spell_to_spawn = spell.instance()
	spell_to_spawn.global_position = owner.global_position
	get_tree().root.call_deferred("add_child", spell_to_spawn)
	
	
func on_spawn_timer_timeout() -> void:
	for amount in spawn_amount:
		spawn_spell()
		
	spawn_timer.start(spawn_cooldown)
