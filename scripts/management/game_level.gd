extends Node2D
class_name GameLevel

export(PackedScene) var background_scene_path

func _ready() -> void:
	randomize()
	var _start: bool = transition_screen.connect("start_scene", self, "start_scene")
	
	
func start_scene() -> void:
	var background: ParallaxBackground = spawn_background()
	var character = load(global_data.character_scene_path).instance()
	var _character_fade_out: bool = background.connect("full_visible", character, "fade_out")
	
	character.global_position = Vector2(480, 270)
	add_child(character)
	
	
func spawn_background():
	var background_scene = background_scene_path.instance()
	add_child(background_scene)
	return background_scene
