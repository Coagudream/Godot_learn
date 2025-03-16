class_name Card
extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Target {SELF, SINGLE_ENEIEY,ALL_ENEMY,EVERYONE}
enum Rarity {COMMON, UNCOMMON, RARE}

const RARITY_COLORS := {
	Card.Rarity.COMMON: Color.GRAY,
	Card.Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	Card.Rarity.RARE: Color.GOLD,
}


@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int
@export var rarity: Rarity

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String
@export var sound :AudioStream

#主方法
func play(targets:Array[Node],char_stats:CharacterStats) -> void:
	Events.card_play.emit(self)
	char_stats.mana -= cost
	
	if is_single_targeted():
		apply_effect(targets)
	else:
		apply_effect(_get_targets(targets))
	
	
	
##返回是否是一个单一目标
func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEIEY


##返回目标数组
func _get_targets(targets:Array[Node]) -> Array[Node]:
	if not targets:
		return []
	
	#因为资源不在场景树内，所以需要一个节点来获取场景树
	var tree := targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMY:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("enemies") +  tree.get_nodes_in_group("player")
		_:
			return []


#抽象方法
func apply_effect(targets:Array[Node]) -> void:
	pass
