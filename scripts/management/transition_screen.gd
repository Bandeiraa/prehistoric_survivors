extends CanvasLayer
class_name TransitionScreen

signal start_scene

onready var animation: AnimationPlayer = get_node("Animation")

var target_scene_path: String

func fade_in(scene_path: String) -> void:
	animation.play("fade_in")
	target_scene_path = scene_path
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
			var _change_scene: bool = get_tree().change_scene(target_scene_path)
			animation.play("fade_out")
			
		"fade_out":
			emit_signal("start_scene")
