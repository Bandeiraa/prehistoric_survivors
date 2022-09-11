extends Node2D
class_name GameLevel

func _ready() -> void:
	randomize()
	var _start: bool = transition_screen.connect("start_scene", self, "start_scene")
	
	
func start_scene() -> void:
	var character = load(global_data.character_scene_path).instance()
	add_child(character)
