extends Node2D
class_name Player
## Base player class with multiplayer authority setup.
##
## The Input node authority is set to the owning player (peer_id = node name).
## The Player node itself remains owned by the server (default).

@onready var input: PlayerInput = %Input
@export var local_mode := false

var rotation_force: float: 
	get:
		return input.rotation_force

var thrust_force: float: 
	get:
		return input.thrust_force


var rotation_enabled := true:
	get:
		return input.rotation_enabled
	set(value):
		if input:
			input.rotation_enabled = value
		
var thrust_enabled := true:
	get:
		return input.thrust_enabled
	set(value):
		if input:
			input.thrust_enabled = value

func _ready():
	if input != null and local_mode == false:
		input.set_multiplayer_authority(int(name))
