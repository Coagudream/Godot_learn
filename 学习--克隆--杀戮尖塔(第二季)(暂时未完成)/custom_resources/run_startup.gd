##数据在不同场景之间的切换
class_name RunStartup
extends Resource

enum Type {NEW_RUN,CONTINUED_RUN}

@export var type:Type
@export var picked_character:CharacterStats 
