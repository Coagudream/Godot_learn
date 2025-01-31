extends HBoxContainer


@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func updata_intent(intent:Intent) ->void:
	if not intent:
		hide()
		return
	
	texture_rect.texture = intent.icon
	texture_rect.visible = texture_rect.texture != null
	label.text = str(intent.number)
	label.visible = intent.number.length() > 0
	
	show()
