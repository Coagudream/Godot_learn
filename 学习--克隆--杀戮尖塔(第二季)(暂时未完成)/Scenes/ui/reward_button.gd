class_name RewardButton
extends Button

@onready var custom_icon: TextureRect = %CustomIcon
@onready var custom_text: Label = %CustomText

@export var reward_icon: Texture:
	set(v):
		reward_icon = v
		
		if not is_node_ready():
			await ready
		
		custom_icon.texture = reward_icon

@export var reward_text: String:
	set(v):
		reward_text = v
		
		if not is_node_ready():
			await ready
		
		custom_text.text = reward_text


func _on_pressed() -> void:
	queue_free()
