extends Sprite
class_name CharacterTexture

var type_list: Array

export(String) var type_1
export(String) var type_2

func _ready() -> void:
	randomize()
	define_character_texture()
	
	
func define_character_texture() -> void:
	type_list = [type_1, type_2]
	var random_index: int = randi() % type_list.size()
	texture = load(type_list[random_index])
