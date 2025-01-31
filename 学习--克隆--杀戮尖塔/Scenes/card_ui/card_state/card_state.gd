class_name CardState
extends Node

enum State{BASE,CLICKED,DRAGGING,AIMING,RELEASED}

##定义状态转换调用的函数
signal transition_requested(from:CardState, to:State)

@export var state :State
var card_ui : CardUI

##进入状态调用
func enter() ->void :
	pass

##退出状态调用
func exit() -> void :
	pass

func on_input(_event:InputEvent) -> void :
	pass

func on_gui_input(_event:InputEvent) -> void :
	pass
	
func on_mouse_entered() -> void :
	pass

func on_mouse_exited() -> void :
	pass
	
