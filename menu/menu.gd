extends Control
class_name Menu

@onready var title_label = %TitleLabel

@export var title := "Something":
	set(value):
		title = value
		if title_label:
			title_label.text = title

@export var show := false:
	set(value):
		if is_multiplayer_authority() and value == true:
			show = value
			if show:
				show_menu.rpc()
			else:
				hide_menu.rpc()
		if not is_multiplayer_authority() and value == false:
			hide_menu()
@onready var v_box_container = %VBoxContainer

@export var buttons : Array[Node]

func _ready():
	for button in buttons:
		button.reparent(v_box_container)

	title_label.text = title
	# Appliquer la visibilité initiale sans déclencher les RPC
	if show:
		visible = true
		process_mode = Node.PROCESS_MODE_INHERIT
		mouse_filter = Control.MOUSE_FILTER_PASS
	else:
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED
		mouse_filter = Control.MOUSE_FILTER_IGNORE

@rpc("any_peer", "call_local")
func hide_menu():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	mouse_filter = Control.MOUSE_FILTER_IGNORE

@rpc("any_peer", "call_local")
func show_menu():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	mouse_filter = Control.MOUSE_FILTER_PASS
