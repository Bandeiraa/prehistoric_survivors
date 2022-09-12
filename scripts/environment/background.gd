extends ParallaxBackground
class_name Background

signal full_visible

func on_animation_finished(_anim_name: String) -> void:
	emit_signal("full_visible")
