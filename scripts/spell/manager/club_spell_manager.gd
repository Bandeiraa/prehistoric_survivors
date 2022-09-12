extends SpellManager
class_name ClubSpellManager

func spawn_spell() -> void:
	can_attack = false
	
	var spell_to_spawn = spell.instance()
	var direction: Vector2 = get_global_mouse_position() - owner.global_position
	
	spell_to_spawn.global_position = owner.spell_spawn_position.global_position
	spell_to_spawn.direction = direction.normalized()
	
	get_tree().root.call_deferred("add_child", spell_to_spawn)
	spawn_timer.start(spawn_cooldown)
	
	
func on_spawn_timer_timeout() -> void:
	can_attack = true
