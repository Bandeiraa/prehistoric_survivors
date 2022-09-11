extends Control
class_name InitialScreen

onready var bottom: TextureRect = get_node("Bottom")
onready var character_sprite: Sprite = get_node("HContainer/CharacterContainer/Pivot/Texture")

onready var left_button: TextureButton = get_node("HContainer/LeftContainer/Left")
onready var right_button: TextureButton = get_node("HContainer/RightContainer/Right")

var current_character_index: int = 1

var character_info_dict: Dictionary = {
	"1": {
		"character_name": "res://assets/interface/text/egg_shell.png",
		"character_sprite_sheet": [
			"res://assets/characters/egg_shell/1.png",
			"res://assets/characters/egg_shell/2.png"
		]
	},
	
	"2": {
		"character_name": "res://assets/interface/text/girl.png",
		"character_sprite_sheet": [
			"res://assets/characters/girl/1.png",
			"res://assets/characters/girl/2.png"
		]
	},
	
	"3": {
		"character_name": "res://assets/interface/text/lion.png",
		"character_sprite_sheet": [
			"res://assets/characters/lion/1.png",
			"res://assets/characters/lion/2.png"
		]
	}
}

func _ready() -> void:
	randomize()
	connect_signals()
	
	
func connect_signals() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		
		
func on_button_pressed(button: TextureButton) -> void:
	match button.name:
		"Left":
			change_button_index(-1)
			
		"Right":
			change_button_index(1)
			
			
func change_button_index(value: int) -> void:
	current_character_index = int(clamp(current_character_index + value, 1, character_info_dict.size()))
	
	left_button.disabled = false
	right_button.disabled = false
	
	if current_character_index == 1:
		left_button.disabled = true
		right_button.disabled = false
		
	if current_character_index == character_info_dict.size():
		left_button.disabled = false
		right_button.disabled = true
		
	var character_name = character_info_dict[str(current_character_index)]["character_name"]
	bottom.texture = load(character_name)
	
	var texture_list: Array = character_info_dict[str(current_character_index)]["character_sprite_sheet"]
	var random_index: int = randi() % texture_list.size()
	character_sprite.texture = load(texture_list[random_index])
