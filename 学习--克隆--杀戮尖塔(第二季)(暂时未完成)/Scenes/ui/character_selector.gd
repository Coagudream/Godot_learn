extends Control

const WIZARD_STATS = preload("res://Characters/wizard/wizard.tres")
const WARRIOR_STATS = preload("res://Characters/warrior/warrior.tres")
const ASSASSIN_STATS = preload("res://Characters/assassin/assassin.tres")
const RUN_SCENE = preload("res://Scenes/run/run.tscn")

@onready var char_name: Label = %CharName
@onready var description: Label = %Description
@onready var char_icon: TextureRect = %CharIcon
@onready var start_button: Button = $StartButton

@export var run_startup: RunStartup

var current_character:CharacterStats :
	set(v):
		current_character = v
		
		char_name.text = current_character.character_name
		description.text = current_character.description
		char_icon.texture = current_character.portrait

func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	print("用 %s 开始游戏" % current_character.character_name)
	
	run_startup.type = RunStartup.Type.NEW_RUN
	run_startup.picked_character = current_character
	get_tree().change_scene_to_packed(RUN_SCENE)


func _on_warrior_button_pressed() -> void:
	current_character = WARRIOR_STATS
	is_start_run()


func _on_wizar_button_pressed() -> void:
	current_character = WIZARD_STATS
	is_start_run()


func _on_assassin_button_pressed() -> void:
	current_character = ASSASSIN_STATS
	is_start_run()


func is_start_run() -> void:
	if start_button.disabled == false:
		return
	
	start_button.disabled = false
