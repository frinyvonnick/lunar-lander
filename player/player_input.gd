extends OnlineInput
class_name PlayerInput

@export var rotation_force : float
@export var thrust_force : float
@export var rotation_enabled := true
@export var thrust_enabled := true

func _process(delta):
	if not is_multiplayer_authority():
		return
	if rotation_enabled:
		if Input.is_action_pressed("rotate_left"):
			rotation_force = -1
			
		if Input.is_action_pressed("rotate_right"):
			rotation_force = 1
			
		if Input.is_action_just_released("rotate_left") or Input.is_action_just_released("rotate_right"):
			rotation_force = 0
	
	if thrust_enabled:
		if Input.is_action_pressed("thrust"):
			thrust_force = 1
			
		if Input.is_action_just_released("thrust"):
			thrust_force = 0
