class_name BlockEffect
extends Effect

var amount: int = 0

func execute(targets:Array[Node]) -> void:
	for target in targets:
		
		if not target:
			continue
		
		if target is Enemy or Player:
			target.stats.block += amount
			SFXPlayer.play(sound)
