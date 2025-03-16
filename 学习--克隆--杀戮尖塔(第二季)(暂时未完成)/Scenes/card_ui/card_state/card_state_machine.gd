class_name CardStateMachine
extends Node

@export var initial_state:CardState

##当前状态
var current_state :CardState
##全部状态字典
var states := {}

##初始化函数
func init(card:CardUI) -> void:
	for child in get_children():
		if child is CardState:#安全检查
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requseted)
			child.card_ui = card
	
	if initial_state :
		initial_state.enter()
		current_state = initial_state
	
func on_input(event:InputEvent) -> void :
	if current_state:
		current_state.on_input(event)
	
func on_gui_input(event:InputEvent) -> void :
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered() -> void :
	if current_state:
		current_state.on_mouse_entered()
		
func on_mouse_exited() -> void :
	if current_state:
		current_state.on_mouse_exited()


##过渡函数
func _on_transition_requseted(from:CardState,to:CardState.State) -> void:
	if from != current_state:  #安全检查
		return
	
	var new_state : CardState = states[to]
	
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
