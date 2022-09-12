extends Node2D
class_name GameLevel

export(PackedScene) var background

func _ready() -> void:
	randomize()
	var _start: bool = transition_screen.connect("start_scene", self, "start_scene")
	
	
func spawn_background() -> void:
	var background_scene = background.instance()
	add_child(background_scene)
	
	
func start_scene() -> void:
	spawn_background()
	
	var character = load(global_data.character_scene_path).instance()
	character.global_position = Vector2(480, 270)
	add_child(character)
