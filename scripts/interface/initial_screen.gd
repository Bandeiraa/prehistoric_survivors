extends Control
class_name InitialScreen

onready var bottom: TextureRect = get_node("Bottom")

onready var character_sprite: Sprite = get_node("HContainer/CharacterContainer/Pivot/Texture")
onready var character_animation: AnimationPlayer = get_node("HContainer/CharacterContainer/Pivot/Animation")

onready var left_button: TextureButton = get_node("HContainer/LeftContainer/Left")
onready var right_button: TextureButton = get_node("HContainer/RightContainer/Right")

var can_click: bool = false
var already_selected: bool = false

var current_texture_index: int = 0
var current_character_index: int = 1

var scene_path: String

var character_info_dict: Dictionary = {
	"1": {
		"character_name": "res://assets/interface/text/egg_shell.png",
		"character_sprite_sheet": [
			"res://assets/characters/egg_shell/1.png",
			"res://assets/characters/egg_shell/2.png"
		],
		
		"scene_path": "res://scenes/character/egg_shell.tscn"
	},
	
	"2": {
		"character_name": "res://assets/interface/text/girl.png",
		"character_sprite_sheet": [
			"res://assets/characters/girl/1.png",
			"res://assets/characters/girl/2.png"
		],
		
		"scene_path": "res://scenes/character/girl.tscn"
	},
	
	"3": {
		"character_name": "res://assets/interface/text/lion.png",
		"character_sprite_sheet": [
			"res://assets/characters/lion/1.png",
			"res://assets/characters/lion/2.png"
		],
		
		"scene_path": "res://scenes/character/lion.tscn"
	}
}

func _ready() -> void:
	randomize()
	var _start: bool = transition_screen.connect("start_scene", self, "start_scene")
	
	
func start_scene() -> void:
	connect_signals()
	change_button_index(0)
	
	
func connect_signals() -> void:
	var _exited: bool = bottom.connect("mouse_exited", self, "mouse_interaction", ["exited", bottom])
	var _entered: bool = bottom.connect("mouse_entered", self, "mouse_interaction", ["entered", bottom])
	
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		
		
func mouse_interaction(state: String, entity) -> void:
	match state:
		"exited":
			can_click = false
			entity.modulate.a = 1.0
			
		"entered":
			can_click = true
			entity.modulate.a = 0.5
			
			
func on_button_pressed(button: TextureButton) -> void:
	match button.name:
		"Left":
			change_button_index(-1)
			
		"Right":
			change_button_index(1)
			
			
func change_button_index(value: int) -> void:
	current_character_index = int(clamp(current_character_index + value, 1, character_info_dict.size()))
	
	change_button_state(false, false)
	
	if current_character_index == 1:
		change_button_state(true, false)
		
	if current_character_index == character_info_dict.size():
		change_button_state(false, true)
		
	var character_name = character_info_dict[str(current_character_index)]["character_name"]
	bottom.texture = load(character_name)
	
	var texture_list: Array = character_info_dict[str(current_character_index)]["character_sprite_sheet"]
	character_sprite.texture = load(texture_list[current_texture_index])
	
	var character_scene_path: String = character_info_dict[str(current_character_index)]["scene_path"]
	scene_path = character_scene_path
	
	
func change_button_state(left_button_state: bool, right_button_state: bool) -> void:
	left_button.disabled = left_button_state
	right_button.disabled = right_button_state
	
	
func _process(_delta: float) -> void:
	if already_selected:
		return
		
	if can_click and Input.is_action_just_pressed("ui_click"):
		already_selected = true
		global_data.character_scene_path = scene_path
		transition_screen.fade_in("res://scenes/management/game_level.tscn")
		
		
func on_character_animation_finished(_anim_name: String) -> void:
	current_texture_index += 1
	current_texture_index = current_texture_index % 2
	
	change_button_index(0)
	character_animation.play("showcase")
